<?php
/*********************************************************************
    zk_equipment.php  —  ZKTeco / Módulo "Equipamentos por Ticket"

    CUSTOMIZAÇÃO ZKTeco (não faz parte do core do osTicket).
    Permite VÁRIOS equipamentos (line-items) por chamado, cada um com
    modelo, nº de série, descrição, observação e STATUS individual, que
    o agente evolui e o cliente acompanha dentro do mesmo ticket.

    Carregado 1x por requisição a partir de bootstrap.php (linha marcada
    /* ZK-EQUIP */ /*). Documentado em:
    OneDrive .../Manutenção/V3/CUSTOMIZACOES_OSTICKET.md

    Tabelas: ost_zk_equipment, ost_zk_equipment_event (próprias, imunes a upgrade).
**********************************************************************/
if (!defined('INCLUDE_DIR')) die('Access Denied');
require_once(INCLUDE_DIR.'class.file.php');

/* Nomes de tabela resolvidos de forma preguiçosa: TABLE_PREFIX pode ainda
   não estar definido no momento em que o bootstrap carrega este módulo. */
function zk_equip_table()       { return TABLE_PREFIX.'zk_equipment'; }
function zk_equip_event_table() { return TABLE_PREFIX.'zk_equipment_event'; }
function zk_equip_file_table()  { return TABLE_PREFIX.'zk_equipment_file'; }

/* ------------------------------------------------------------------ *
 *  Telefone/WhatsApp — não é sobre equipamentos, mas este arquivo já é
 *  o ponto único de "customizações gerais do cliente" carregado 1x por
 *  requisição, então a função mora aqui em vez de criar outro módulo.
 * ------------------------------------------------------------------ */
function zk_whatsapp_url($phone) {
    $digits = preg_replace('/\D+/', '', (string) $phone);
    if ($digits === '')
        return '';
    // Número brasileiro sem código do país (DDD + número, 10 ou 11 dígitos)
    if (strlen($digits) <= 11)
        $digits = '55'.$digits;
    return 'https://wa.me/'.$digits;
}

/* ------------------------------------------------------------------ *
 *  Ciclo de status (fonte única para os 3 lados)
 *  done=true  => item concluído (conta em "X/N concluídos")
 *  weight     => % de conclusão da etapa (0-100), para o PROGRESSO
 *                PONDERADO: o progresso do chamado é a MÉDIA dos pesos
 *                dos seus equipamentos. Assim a barra evolui suave
 *                (Em análise=25%, Em reparo=70%...) em vez de pular de
 *                0 para 100. Ajustar aqui reflete nos 3 lados.
 * ------------------------------------------------------------------ */
function zk_equip_statuses() {
    return array(
        'aguardando_envio'   => array('label' => 'Aguardando envio',   'color' => 'var(--zk-tag-gray)',   'done' => false, 'weight' => 0),
        'em_transporte'      => array('label' => 'Em transporte',      'color' => 'var(--zk-tag-cyan)',   'done' => false, 'weight' => 10),
        'recebido'           => array('label' => 'Recebido',           'color' => 'var(--zk-tag-blue)',   'done' => false, 'weight' => 20),
        'em_diagnostico'     => array('label' => 'Em diagnóstico',     'color' => 'var(--zk-tag-purple)', 'done' => false, 'weight' => 35),
        'aguardando_cliente' => array('label' => 'Aguardando cliente', 'color' => 'var(--zk-tag-yellow)', 'done' => false, 'weight' => 40),
        'aguardando_peca'    => array('label' => 'Aguardando peça',    'color' => 'var(--zk-tag-yellow)', 'done' => false, 'weight' => 45),
        'em_manutencao'      => array('label' => 'Em manutenção',      'color' => 'var(--zk-tag-purple)', 'done' => false, 'weight' => 65),
        'em_testes'          => array('label' => 'Em testes',          'color' => 'var(--zk-tag-cyan)',   'done' => false, 'weight' => 85),
        'concluido'          => array('label' => 'Concluído',          'color' => 'var(--zk-tag-green)',  'done' => true,  'weight' => 100),
        'bloqueado'          => array('label' => 'Bloqueado',          'color' => 'var(--zk-tag-red)',    'done' => false, 'weight' => 50),
        'cancelado'          => array('label' => 'Cancelado',          'color' => 'var(--zk-tag-gray)',   'done' => true,  'weight' => 100),
    );
}
function zk_equip_default_status() { return 'aguardando_envio'; }
/* Peso (0-100) da etapa, para o progresso ponderado. */
function zk_equip_status_weight($key) {
    $s = zk_equip_statuses();
    return isset($s[$key]) ? (int) $s[$key]['weight'] : 0;
}
/* Progresso ponderado (0-100) a partir de um mapa status=>contagem. */
function zk_equip_progress_from_counts($counts, $total) {
    if (!$total) return 0;
    $sum = 0;
    foreach ((array) $counts as $key => $c)
        $sum += zk_equip_status_weight($key) * (int) $c;
    return (int) round($sum / $total);
}
function zk_equip_status_label($key) {
    $s = zk_equip_statuses();
    return isset($s[$key]) ? $s[$key]['label'] : $key;
}
function zk_equip_status_color($key) {
    $s = zk_equip_statuses();
    return isset($s[$key]) ? $s[$key]['color'] : 'var(--zk-tag-gray)';
}

/* ------------------------------------------------------------------ *
 *  Pendência (fonte única para os 3 lados) — igual ao ciclo de status,
 *  mas é um campo à parte: sinaliza uma pendência administrativa do
 *  equipamento (ex.: falta um documento), não o andamento do reparo em
 *  si. '' (string vazia) = sem pendência.
 *
 *  As marcadas como MANAGED são mantidas automaticamente por
 *  zk_sync_equip_pendencia() a partir do estado da Nota Fiscal do
 *  chamado (presença + resultado da verificação do XML) e do Envio do
 *  produto (transportadora/rastreio informados pelo cliente).
 *  'aguardando_rastreio' continua sendo escolhida manualmente pelo
 *  agente (não mexe com ela).
 * ------------------------------------------------------------------ */
function zk_equip_pendencias() {
    return array(
        'sem_nf'              => array('label' => 'Sem nota fiscal',                'color' => '#c0392b'),
        'nf_nao_verificada'   => array('label' => 'Nota anexada, mas não verificada','color' => '#d99a00'),
        'nf_com_erro'         => array('label' => 'Nota fiscal com erro',           'color' => '#c0392b'),
        'envio_nao_informado' => array('label' => 'Envio do produto não informado', 'color' => '#d99a00'),
        'envio_nao_confirmado'=> array('label' => 'Aguardando confirmação do envio','color' => '#d99a00'),
        'aguardando_rastreio' => array('label' => 'Aguardando rastreio de envio',   'color' => '#d99a00'),
    );
}
// Chaves de pendência controladas automaticamente (estado da NF + envio) —
// zk_sync_equip_pendencia() só sobrescreve a pendência de um equipamento
// se ela já estiver vazia ou for uma dessas (nunca pisa em algo que o
// agente tenha escolhido manualmente, como "aguardando_rastreio").
function zk_equip_pendencias_managed() {
    return array('', 'sem_nf', 'nf_nao_verificada', 'nf_com_erro',
        'envio_nao_informado', 'envio_nao_confirmado');
}
function zk_equip_default_pendencia() { return ''; }
function zk_equip_pendencia_label($key) {
    if ($key === '' || $key === null) return '';
    $p = zk_equip_pendencias();
    return isset($p[$key]) ? $p[$key]['label'] : $key;
}
function zk_equip_pendencia_color($key) {
    $p = zk_equip_pendencias();
    return isset($p[$key]) ? $p[$key]['color'] : '#9aa0a6';
}

/* Pendências distintas por ticket, para o selo na listagem de Chamados.
   Uma consulta só pra todos os tickets da página (evita N+1). Retorna
   array($ticket_id => array($pendKey => true, ...)). */
function zk_equip_pendencias_for_tickets($ticket_ids) {
    $out = array();
    $ids = array_filter(array_map('intval', (array) $ticket_ids));
    if (!$ids)
        return $out;
    $res = db_query('SELECT DISTINCT ticket_id, pendencia FROM '.zk_equip_table()
                   .' WHERE ticket_id IN ('.implode(',', $ids).") AND pendencia != ''");
    if ($res) {
        while ($r = db_fetch_array($res))
            $out[(int) $r['ticket_id']][$r['pendencia']] = true;
    }
    return $out;
}

/* Total e concluídos de equipamentos por ticket, para a sub-linha do
   Assunto na listagem de Chamados. Uma consulta só pra página toda
   (evita N+1). Retorna array($ticket_id => array('total'=>N,'done'=>X)). */
function zk_equip_counts_for_tickets($ticket_ids) {
    $out = array();
    $ids = array_filter(array_map('intval', (array) $ticket_ids));
    if (!$ids)
        return $out;
    $done = array();
    $wcase = 'CASE status'; // expressão de peso p/ o progresso ponderado
    foreach (zk_equip_statuses() as $key => $meta) {
        if (!empty($meta['done']))
            $done[] = db_input($key);
        $wcase .= ' WHEN '.db_input($key).' THEN '.(int) $meta['weight'];
    }
    $wcase .= ' ELSE 0 END';
    $res = db_query('SELECT ticket_id, COUNT(*) AS total,'
                   .' SUM(status IN ('.implode(',', $done).')) AS done,'
                   .' AVG('.$wcase.') AS pct'
                   .' FROM '.zk_equip_table()
                   .' WHERE ticket_id IN ('.implode(',', $ids).')'
                   .' GROUP BY ticket_id');
    if ($res) {
        while ($r = db_fetch_array($res))
            $out[(int) $r['ticket_id']] = array(
                'total' => (int) $r['total'],
                'done'  => (int) $r['done'],
                'pct'   => (int) round((float) $r['pct']),
            );
    }
    return $out;
}

/* ------------------------------------------------------------------ *
 *  Assunto automático a partir dos equipamentos — FONTE ÚNICA (usada
 *  na criação e na regeração pós-edição; o JS de open.inc.php espelha
 *  esta mesma regra no cliente).
 *  1 item  -> "Manutenção — Modelo (S/N X)"
 *  N itens -> "Manutenção — N equipamentos: 4× ModeloA, ModeloB" —
 *             agrupado por modelo (ordem de cadastro), com contagem
 *             quando repete; o que não couber no limite vira
 *             "+K modelos"; se nem o 1º modelo couber, cai no formato
 *             simples "Manutenção — N equipamentos".
 *  $items aceita tanto linhas do banco (numero_serie) quanto do POST
 *  (serie). $limit deve casar com o length do campo subject no banco.
 * ------------------------------------------------------------------ */
function zk_equip_subject_text($items, $limit = 70) {
    $items = array_values((array) $items);
    $n = count($items);
    if (!$n)
        return '';
    if ($n == 1) {
        $m = trim((string) $items[0]['modelo']);
        $s = isset($items[0]['numero_serie']) ? trim((string) $items[0]['numero_serie'])
           : (isset($items[0]['serie']) ? trim((string) $items[0]['serie']) : '');
        return mb_substr('Manutenção — '.$m.($s !== '' ? ' (S/N '.$s.')' : ''), 0, $limit);
    }
    // agrupa por modelo preservando a ordem de cadastro
    $counts = array();
    foreach ($items as $it) {
        $m = trim((string) $it['modelo']);
        if ($m === '') continue;
        if (!isset($counts[$m])) $counts[$m] = 0;
        $counts[$m]++;
    }
    $parts = array();
    foreach ($counts as $m => $c)
        $parts[] = ($c > 1 ? $c.'× ' : '').$m;
    $prefix = 'Manutenção — '.$n.' equipamentos: ';
    // vai tirando modelos do fim até caber; o excedente vira "+K modelos"
    for ($k = count($parts); $k >= 1; $k--) {
        $rest = count($parts) - $k;
        $subj = $prefix.implode(', ', array_slice($parts, 0, $k))
              .($rest ? ' +'.$rest.' modelo'.($rest > 1 ? 's' : '') : '');
        if (mb_strlen($subj) <= $limit)
            return $subj;
    }
    return mb_substr('Manutenção — '.$n.' equipamentos', 0, $limit);
}

function zk_equip_request_rows() {
    $raw = isset($_POST['zk_equipments_json']) ? $_POST['zk_equipments_json'] : '';
    if ($raw && is_string($raw)) {
        $rows = json_decode($raw, true);
        if (is_array($rows))
            return $rows;
    }

    $rows = array();
    $modelos = isset($_POST['zk_modelo']) && is_array($_POST['zk_modelo']) ? $_POST['zk_modelo'] : array();
    foreach ($modelos as $i => $modelo) {
        $rows[] = array(
            'modelo'       => $modelo,
            'serie'        => isset($_POST['zk_serie'][$i]) ? $_POST['zk_serie'][$i] : '',
            'resumo'       => isset($_POST['zk_resumo'][$i]) ? $_POST['zk_resumo'][$i] : '',
            'detalhamento' => isset($_POST['zk_detalhamento'][$i]) ? $_POST['zk_detalhamento'][$i] : '',
            'photo_key'    => isset($_POST['zk_photo_key'][$i]) ? $_POST['zk_photo_key'][$i] : '',
        );
    }
    return $rows;
}

/* ------------------------------------------------------------------ *
 *  CSS compartilhado (embutido). Fica no módulo porque o painel do
 *  AGENTE (SCP) não carrega o theme.css do cliente. Guard estático
 *  evita duplicar se chamado mais de uma vez na mesma página.
 * ------------------------------------------------------------------ */
function zk_equip_styles() {
    static $done = false;
    if ($done) return;
    $done = true;
    echo <<<CSS
<style type="text/css">
/* ===== ZKTeco — Equipamentos por Ticket ===== */
#zk-equip, .zk-panel { font-size:13px; color:#555; }
.zk-panel { margin:18px 0; }
.zk-panel-title { color:#474B4F; font-size:15px; font-weight:600; margin:0 0 10px;
  padding-left:10px; border-left:3px solid #7AC143; }
/* Progresso */
.zk-progress-wrap { margin:6px 0 14px; }
.zk-progress-top { color:#474B4F; margin-bottom:5px; }
.zk-progress-pct { color:#8a8f8a; }
.zk-progress-bar { height:10px; background:#eceee9; border-radius:6px; overflow:hidden; }
.zk-progress-bar > span { display:block; height:100%; background:#7AC143; border-radius:6px; transition:width .3s ease; }
.zk-progress-big { font-size:18px; font-weight:700; color:#649E37; }
.zk-eqp-mini { height:5px; background:#eceee9; border-radius:4px; overflow:hidden; margin-top:6px; }
.zk-eqp-mini > span { display:block; height:100%; border-radius:4px; background:#7AC143; transition:width .25s ease, background .25s ease; }
.zk-chips { margin-top:8px; }
.zk-chip { display:inline-block; border:1px solid #ddd; border-radius:20px;
  padding:2px 10px; margin:3px 6px 3px 0; font-size:12px; color:#474B4F; background:#fff; }
.zk-dot { display:inline-block; width:8px; height:8px; border-radius:50%; margin-right:5px; vertical-align:middle; }
/* Tabelas dos painéis */
.zk-table-wrap { max-height:520px; overflow:auto; border:1px solid #e3e6e2; border-radius:6px; }
.zk-table { width:100%; border-collapse:collapse; background:#fff; }
.zk-table thead th { position:sticky; top:0; background:#f5f7f4; color:#474B4F; text-align:left;
  font-weight:600; font-size:12px; padding:8px 10px; border-bottom:1px solid #e3e6e2; z-index:1; }
.zk-table td { padding:8px 10px; border-bottom:1px solid #f0f2ef; vertical-align:top; }
.zk-table tbody tr:hover, .zk-table tbody tr:hover { background:#fafcf8; }
.zk-sub { font-size:12px; color:#777; margin-top:2px; }
.zk-muted { color:#9aa0a6; }
.zk-nowrap { white-space:nowrap; }
/* Tag estilo Carbon: pílula clara derivada de UMA cor (--badge-c) via color-mix —
   ambiente é sempre navegador atual (mesma política já adotada pro uso de :has()
   neste projeto), sem necessidade de fallback pra navegador antigo. */
.zk-badge { display:inline-block; font-size:11px; font-weight:600; white-space:nowrap;
  padding:2px 10px; border-radius:999px;
  color:var(--badge-c, #474B4F);
  background:color-mix(in srgb, var(--badge-c, #474B4F) 14%, #fff);
  border:1px solid color-mix(in srgb, var(--badge-c, #474B4F) 45%, #fff); }
.zk-toolbar { margin:10px 0; display:flex; flex-wrap:wrap; align-items:center; gap:10px; }
.zk-search { padding:7px 10px; border:1px solid #ccc; border-radius:6px; font-size:13px; width:260px; max-width:100%; }
/* Cabeçalho do painel (título + ações/estados à direita) */
.zk-panel-head { display:flex; flex-wrap:wrap; justify-content:space-between; align-items:center; gap:10px; }
.zk-panel-head .zk-panel-title { margin:0; }
.zk-panel-head .zk-ticket-nf-status { max-width:100%; min-width:0; display:flex; align-items:center; gap:8px; flex-wrap:wrap; }
.zk-nf-verify-form { display:inline-flex; margin:0; }
.zk-nf-verify-btn { display:inline-flex; align-items:center; gap:5px; padding:5px 10px;
  border:1px solid #cfd5cc; border-radius:14px; background:#fff; color:#474B4F; cursor:pointer;
  font-size:11px; font-weight:600; white-space:nowrap; }
.zk-nf-verify-btn:hover { background:#eef7e6; border-color:#7AC143; color:#649E37; }
.zk-nf-verify-btn i { font-size:12px; }
/* Selo "XML validado" — upload verifica automaticamente; quando passa,
   este selo substitui o botão "Verificar XML" */
.zk-nf-valid { display:inline-flex; align-items:center; gap:5px; padding:3px 10px;
  border:1px solid #bfe0a4; border-radius:14px; background:#eef7e6;
  color:#649E37; font-size:11px; font-weight:700; white-space:nowrap; }
/* ===== Guia de próximos passos (painel do cliente) =====
   Destaca a AÇÃO atual em tamanho grande — clipe/select pequenos
   passavam despercebidos em teste com usuário real. */
.zk-guide { display:flex; gap:16px; align-items:flex-start; margin:14px 0 4px;
  padding:16px 20px; border:1px solid #d5e6c2; border-radius:10px;
  background:linear-gradient(180deg,#f5faee,#edf6e3); }
.zk-guide-step { flex:0 0 auto; width:36px; height:36px; border-radius:50%;
  display:inline-flex; align-items:center; justify-content:center;
  background:#7AC143; color:#fff; font-weight:700; font-size:16px;
  box-shadow:0 3px 8px rgba(122,193,67,.35); }
.zk-guide-body { display:flex; flex-direction:column; gap:6px; min-width:0; flex:1; }
.zk-guide-body > b { font-size:15.5px; color:#474B4F; line-height:1.3; }
.zk-guide-body > span { font-size:13px; color:#5c6258; line-height:1.5; }
.zk-guide-actions { display:flex; align-items:center; gap:12px; flex-wrap:wrap; margin-top:8px; }
.zk-guide-attach { display:inline-flex; align-items:center; gap:10px; cursor:pointer;
  padding:13px 26px; border:0; border-radius:9px;
  background:linear-gradient(180deg,#83cb4d,#6fb43a); color:#fff;
  font-size:14.5px; font-weight:700; box-shadow:0 5px 14px rgba(122,193,67,.32);
  transition:transform .12s ease, box-shadow .12s ease, filter .12s ease; }
.zk-guide-attach:hover { filter:brightness(.97); transform:translateY(-1px);
  box-shadow:0 8px 18px rgba(122,193,67,.4); }
.zk-guide-attach input { display:none; }
.zk-guide-attach i { font-size:15px; }
.zk-guide-hint { font-size:12px; color:#8a8f8a; }
.zk-guide-trail { font-size:12px; color:#8a8f8a; margin-top:4px; }
.zk-guide-trail b { color:#649E37; }
.zk-guide-trail i { color:#649E37; font-size:11px; }
/* campos do envio DENTRO do guia: maiores que os da barra antiga */
.zk-guide .zk-envio-form select,
.zk-guide .zk-envio-form input[type=text] { padding:11px 12px; font-size:14px;
  border-radius:8px; min-width:230px; }
.zk-guide .zk-envio-save { padding:12px 26px; font-size:13.5px; border-radius:9px; }
.zk-guide .zk-envio-confirm { padding:12px 26px; font-size:13.5px; border-radius:9px; }
/* estado "com erro" (âmbar) e estado "tudo certo" */
.zk-guide-warn { background:linear-gradient(180deg,#fdf6ec,#faf0dd); border-color:#ecd5ab; }
.zk-guide-warn .zk-guide-step { background:#d99a00; box-shadow:0 3px 8px rgba(217,154,0,.3); }
.zk-guide-done { align-items:center; background:#f2f8ec; border-color:#cfe6b8; }
.zk-guide-done-ico { color:#649E37; font-size:24px; }
/* Caminho alternativo do CLIENTE FINAL (Declaração de Conteúdo) */
.zk-guide-alt { margin-top:14px; padding-top:12px; border-top:1px dashed #c9dcb2; }
.zk-guide-alt-link { font-size:13px; font-weight:700; color:#649E37;
  text-decoration:underline; cursor:pointer; }
.zk-guide-alt-link:hover { color:#474B4F; }
.zk-guide-alt-body { margin-top:10px; font-size:13px; color:#5c6258; line-height:1.5; }
.zk-guide-attach-alt { background:linear-gradient(180deg,#5c6167,#474B4F);
  box-shadow:0 5px 14px rgba(71,75,79,.3); }
.zk-guide-attach-alt:hover { box-shadow:0 8px 18px rgba(71,75,79,.38); }
.zk-dc-badge { display:inline-flex; align-items:center; gap:5px; padding:3px 10px;
  border:1px solid #cfd5cc; border-radius:14px; background:#f5f7f4;
  color:#474B4F; font-size:11px; font-weight:700; white-space:nowrap; }
@media (max-width:768px){
  .zk-guide { flex-direction:column; gap:10px; }
  .zk-guide .zk-envio-form select,
  .zk-guide .zk-envio-form input[type=text] { min-width:0; width:100%; }
  .zk-guide-attach { width:100%; justify-content:center; box-sizing:border-box; }
}
/* Lixeira da NF no painel do chamado — círculo pequeno, vermelho no hover
   (mesma linguagem do "×" de apagar da tela de editar equipamentos) */
.zk-nf-del-btn { display:inline-flex; align-items:center; justify-content:center;
  width:22px; height:22px; border:1px solid #e3c9c9; border-radius:50%; background:#fff;
  color:#c0392b; cursor:pointer; font-size:11px; padding:0;
  transition:background-color .12s ease,border-color .12s ease,color .12s ease; }
.zk-nf-del-btn:hover { background:#c0392b; border-color:#c0392b; color:#fff; }
/* Anexar NF direto do painel (quando ainda não tem nenhuma) — mesmo
   círculo pequeno clicável usado pra apagar (.zk-ticket-nf-del), só que
   pra anexar, pra ficar óbvio que dá pra agir ali mesmo sem precisar
   abrir a tela de editar equipamentos. */
.zk-nf-quick-upload-form { display:inline-flex; margin:0; }
.zk-nf-quick-upload-btn { display:inline-flex; align-items:center; justify-content:center;
  width:22px; height:22px; border:1px solid #cfd5cc; border-radius:50%; background:#fff;
  color:#474B4F; cursor:pointer; font-size:12px; transition:background-color .12s ease,border-color .12s ease,color .12s ease; }
.zk-nf-quick-upload-btn:hover { background:#eaf2fb; border-color:#2a6ebb; color:#2a6ebb; }
.zk-nf-quick-upload-btn input { display:none; }
/* Dica "como emitir a NF" — botão (?) + balão */
.zk-nf-dica-wrap { position:relative; display:inline-flex; }
.zk-nf-dica-btn { display:inline-flex; align-items:center; justify-content:center;
  width:22px; height:22px; border:1px solid #cfd5cc; border-radius:50%; background:#fff;
  color:#474B4F; cursor:pointer; font-size:12px; font-weight:700; padding:0;
  transition:background-color .12s ease,border-color .12s ease,color .12s ease; }
.zk-nf-dica-btn:hover { background:#eef7e6; border-color:#7AC143; color:#649E37; }
.zk-nf-dica-pop { position:absolute; top:28px; right:0; z-index:50; width:420px; max-width:82vw;
  background:#fff; border:1px solid #cfd5cc; border-radius:8px; box-shadow:0 6px 20px rgba(0,0,0,.15);
  padding:12px 14px; font-size:12.5px; color:#555; text-align:left; line-height:1.5; }
.zk-nf-dica-title { display:block; color:#474B4F; font-size:13px; margin-bottom:6px;
  padding-left:8px; border-left:3px solid #7AC143; }
.zk-nf-dica-sec { display:block; color:#649E37; font-weight:700; font-size:11px;
  text-transform:uppercase; letter-spacing:.4px; margin-top:8px; }
.zk-nf-dica-pop ul { margin:2px 0 0; padding-left:16px; }
.zk-nf-dica-pop li { margin:2px 0; }
/* Envio do produto (transportadora + rastreio) */
.zk-envio-bar { display:flex; flex-wrap:wrap; align-items:center; gap:8px; margin:8px 0 4px;
  padding:8px 12px; border:1px solid #e3e6e2; border-radius:6px; background:#fafcf8; font-size:12.5px; }
.zk-envio-label { color:#474B4F; font-weight:600; white-space:nowrap; }
.zk-envio-form { display:inline-flex; align-items:center; gap:8px; flex-wrap:wrap; margin:0; }
.zk-envio-form select, .zk-envio-form input[type=text] { padding:5px 8px; border:1px solid #ccc;
  border-radius:6px; font-size:12.5px; }
.zk-envio-form input[type=text] { width:200px; text-transform:uppercase; }
.zk-envio-save { padding:5px 14px; border:1px solid #7AC143; border-radius:14px; background:#7AC143;
  color:#fff; cursor:pointer; font-size:11px; font-weight:600; }
.zk-envio-save:hover { background:#649E37; border-color:#649E37; }
.zk-envio-confirm { padding:5px 14px; border:1px solid #649E37; border-radius:14px; background:#649E37;
  color:#fff; cursor:pointer; font-size:11px; font-weight:700; }
.zk-envio-confirm:hover { background:#474B4F; border-color:#474B4F; }
.zk-envio-ok { color:#649E37; font-weight:700; }
/* Caixa de erros da NF (quando a pendência é "Nota fiscal com erro") */
.zk-nf-errors-box { margin:8px 0 4px; padding:10px 14px; border:1px solid #f0c9c9; border-radius:6px;
  background:#fdecea; color:#a5281b; font-size:12.5px; }
.zk-nf-errors-box b { display:block; margin-bottom:4px; }
.zk-nf-errors { margin:6px 0 0; padding-left:18px; }
.zk-nf-errors li { margin:2px 0; }
/* Tabela comparativa dos erros da NF (Campo | Está na NF | Deveria estar) */
.zk-nf-errors-scroll { overflow-x:auto; margin-top:6px; }
.zk-nf-errors-table { width:100%; border-collapse:collapse; background:#fff;
  border:1px solid #f0c9c9; font-size:12.5px; }
.zk-nf-errors-table th { text-align:left; background:#faf1f1; color:#a5281b;
  font-size:11px; text-transform:uppercase; letter-spacing:.3px;
  padding:6px 10px; border-bottom:1px solid #f0c9c9; white-space:nowrap; }
.zk-nf-errors-table th i { font-size:11px; }
.zk-nf-errors-table td { padding:6px 10px; border-top:1px solid #f7e8e8;
  vertical-align:top; color:#474B4F; }
.zk-nf-errors-table tbody tr:first-child td { border-top:0; }
.zk-nf-errors-table .zk-nf-campo { font-weight:600; white-space:nowrap; width:190px; }
.zk-nf-errors-table .zk-nf-est { color:#a5281b; }
.zk-nf-errors-table .zk-nf-esp { color:#33691e; font-weight:600; }
/* Lista de chamados (tela "Chamados") */
#ticketSearchForm .zk-search { flex:1 1 360px; min-width:220px; }
.zk-tickets-states { display:flex; gap:8px; flex-wrap:wrap; }
.zk-state { display:inline-flex; align-items:center; gap:6px; padding:6px 12px; border-radius:20px;
  border:1px solid #ddd; color:#474B4F; text-decoration:none; font-size:12px; background:#fff; }
.zk-state:hover { border-color:#7AC143; color:#649E37; }
.zk-state-active { background:#eef7e6; border-color:#7AC143; color:#649E37; font-weight:600; }
.zk-clear-link { color:#777; font-size:12px; text-decoration:none; white-space:nowrap; }
.zk-clear-link:hover { color:#c0392b; }
#ticketTable caption { text-align:left; color:#9aa0a6; font-size:12px; padding:0 0 8px; }
#ticketTable .zk-issue-line { display:block; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; max-width:420px; }
.zk-pagination { margin-top:10px; color:#474B4F; font-size:13px; }
/* Painel do agente (editável) */
.zk-table.zk-edit td textarea { width:100%; box-sizing:border-box; border:1px solid #d3d7d1;
  border-radius:5px; padding:5px 7px; font-size:12px; resize:vertical; min-height:30px; }
.zk-status-sel { padding:6px 8px; border:1px solid #ccc; border-radius:6px; font-size:12px; max-width:170px; }
.zk-status-sel.zk-changed { border-color:#7AC143; box-shadow:0 0 0 2px rgba(122,193,67,.18); }
.zk-actions { margin-top:12px; display:flex; align-items:center; gap:16px; flex-wrap:wrap; }
.zk-notify { color:#555; font-size:12px; }
.zk-save, .zk-btn { background:#7AC143; color:#fff; border:none; border-radius:6px;
  padding:9px 20px; font-size:13px; font-weight:600; cursor:pointer; }
.zk-save:hover, .zk-btn:hover { background:#649E37; }
.zk-btn-light { background:#eef0ec; color:#474B4F; }
.zk-btn-light:hover { background:#e2e5e0; }
/* Grade de cadastro (cliente) — precisa vencer o #ticketForm > table td{display:block} do tema */
#zk-equip .zk-grid { display:table !important; width:100% !important; border-collapse:collapse; background:#fff; }
#zk-equip .zk-grid thead { display:table-header-group !important; }
#zk-equip .zk-grid tbody { display:table-row-group !important; }
#zk-equip .zk-grid tr { display:table-row !important; }
#zk-equip .zk-grid th, #zk-equip .zk-grid td { display:table-cell !important; width:auto !important;
  padding:6px 8px !important; border-bottom:1px solid #eef1ed; vertical-align:middle; }
#zk-equip .zk-grid thead th { background:#f5f7f4; color:#474B4F; font-size:12px; font-weight:600; }
#zk-equip .zk-grid input { width:100%; box-sizing:border-box; padding:7px 8px; border:1px solid #d3d7d1; border-radius:5px; font-size:13px; }
#zk-equip .zk-grid .zk-c-num { width:34px; text-align:center; color:#9aa0a6; }
#zk-equip .zk-grid .zk-c-del { width:34px; text-align:center; }
#zk-equip .zk-grid .zk-del { color:#c0392b; text-decoration:none; font-size:18px; font-weight:bold; }
#zk-equip .zk-grid .zk-c-photos { width:84px; text-align:center; }
#zk-equip .zk-photo-pair { display:flex; gap:6px; justify-content:center; align-items:center; }
#zk-equip .zk-photo-btn { width:34px; height:34px; display:inline-flex; align-items:center; justify-content:center;
  border:1px solid #cfd5cc; border-radius:6px; background:#fff; color:#474B4F; cursor:pointer;
  box-sizing:border-box; transition:border-color .12s ease,background-color .12s ease,color .12s ease; }
#zk-equip .zk-photo-btn:hover { background:#eef7e6; border-color:#7AC143; color:#649E37; }
#zk-equip .zk-photo-btn.zk-has-file { background:#7AC143; border-color:#649E37; color:#fff; }
#zk-equip .zk-photo-btn input { display:none; }
/* Contador "n/5" sob o botão de anexar — mesma paleta do zk-th-count */
#zk-equip .zk-photo-count { margin-top:3px; font-size:11px; color:#9aa0a6; text-align:center; }
/* Limite atingido (tela de editar — soma fotos já salvas + novas) */
#zk-equip .zk-photo-btn-disabled { cursor:default; opacity:.45; }
#zk-equip .zk-photo-btn-disabled:hover { background:#fff; border-color:#cfd5cc; color:#474B4F; }
#zk-equip .zk-grid tr.zk-invalid input.zk-modelo,
#zk-equip .zk-grid tr.zk-invalid input.zk-serie,
#zk-equip .zk-grid tr.zk-invalid input.zk-resumo,
#zk-equip .zk-grid tr.zk-invalid textarea.zk-detal { border-color:#c0392b; background:#fff6f5; }
#zk-equip .zk-grid tr.zk-invalid .zk-photo-pair .zk-photo-btn:not(.zk-has-file) { border-color:#c0392b; }
/* Nota Fiscal (XML) do CHAMADO — campo único (não é mais por linha),
   um "cartão" clicável simples acima da grade, com estado "preenchido"
   em azul (mesma linguagem visual dos botões de foto/verde, mas outra
   cor pra não parecer mais uma foto). */
#zk-equip .zk-ticket-nf { margin:10px 0 14px; }
#zk-equip .zk-ticket-nf-row { display:flex; align-items:center; gap:10px; flex-wrap:wrap; }
#zk-equip .zk-ticket-nf-upload { display:inline-flex; align-items:center; gap:8px; padding:9px 14px;
  border:1px solid #cfd5cc; border-radius:6px; background:#fff; color:#474B4F; cursor:pointer;
  font-size:13px; font-weight:600; flex:0 0 auto; transition:border-color .12s ease,background-color .12s ease,color .12s ease; }
#zk-equip .zk-ticket-nf-upload:hover { background:#eaf2fb; border-color:#2a6ebb; color:#2a6ebb; }
#zk-equip .zk-ticket-nf-upload.zk-has-file { background:#2a6ebb; border-color:#245c9e; color:#fff; }
#zk-equip .zk-ticket-nf-upload input { display:none; }
#zk-equip .zk-ticket-nf-upload i { font-size:16px; }
#zk-equip .zk-ticket-nf-name { font-size:12px; color:#649E37; font-weight:600; }
/* Estado atual da NF já anexada (tela de editar) — na MESMA linha do
   botão (não empilhado embaixo), com o nome do arquivo truncado com
   reticências se for muito comprido (chave de acesso de NF-e tem 44
   dígitos) — o nome completo fica no title (tooltip) do link. */
#zk-equip .zk-ticket-nf-current { max-width:360px; min-width:0; }
/* Botão "apagar Nota Fiscal" — só aparece quando já tem uma anexada
   (tela de editar). Mesma linguagem visual do "×" de remover linha da
   grade (.zk-del), num círculo pra ficar clicável com folga. */
#zk-equip .zk-ticket-nf-del { flex:0 0 auto; width:22px; height:22px; line-height:20px; padding:0;
  border:1px solid #e3c9c9; border-radius:50%; background:#fff; color:#c0392b;
  font-size:15px; font-weight:bold; text-align:center; cursor:pointer;
  transition:background-color .12s ease,color .12s ease; }
#zk-equip .zk-ticket-nf-del:hover { background:#c0392b; color:#fff; border-color:#c0392b; }
#zk-equip .zk-grid-wrap { max-height:420px; overflow:auto; border:1px solid #e3e6e2; border-radius:6px; }
#zk-equip .zk-grid-actions { margin:10px 0; display:flex; gap:8px; align-items:center; flex-wrap:wrap; }
#zk-equip .zk-count { color:#474B4F; font-weight:600; margin-left:6px; }
/* Pré-visualização das fotos anexadas — abaixo da grade (a célula "Fotos"
   é estreita demais pra caber uma miniatura legível). */
#zk-equip .zk-photo-previews-wrap { margin-top:12px; padding-top:10px; border-top:1px solid #eef1ed; }
#zk-equip .zk-photo-previews-head { font-size:12px; font-weight:600; color:#474B4F; margin-bottom:8px; }
#zk-equip .zk-photo-previews { display:flex; flex-wrap:wrap; gap:10px; }
#zk-equip .zk-photo-preview { position:relative; width:120px; border:1px solid #e3e6e2; border-radius:8px;
  background:#fff; overflow:hidden; box-shadow:0 1px 3px rgba(0,0,0,.05); }
#zk-equip .zk-photo-preview img { display:block; width:100%; height:90px; object-fit:cover; background:#f5f7f4; }
#zk-equip .zk-photo-preview-meta { padding:5px 7px; }
#zk-equip .zk-photo-preview-label,
#zk-equip .zk-photo-preview-name { display:block; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
#zk-equip .zk-photo-preview-label { font-size:11px; font-weight:600; color:#474B4F; }
#zk-equip .zk-photo-preview-name { font-size:10.5px; color:#8a8f8a; }
#zk-equip .zk-photo-preview-del { position:absolute; top:4px; right:4px; width:20px; height:20px;
  line-height:18px; text-align:center; border-radius:50%; background:rgba(0,0,0,.55); color:#fff;
  font-size:14px; font-weight:bold; text-decoration:none; }
#zk-equip .zk-photo-preview-del:hover { background:#c0392b; }
/* Largura total na abertura + painéis largos (o usuário quer usar o espaço) */
#ticketForm { max-width:100% !important; }
.zk-panel { max-width:none !important; }
/* Colunas da grade de cadastro. Resumo e Detalhamento/Observação dividem
   o espaço igualmente (mesma largura). */
#zk-equip .zk-grid .zk-c-num { width:34px; }
#zk-equip .zk-grid .zk-c-modelo { width:14%; }
#zk-equip .zk-grid .zk-c-serie  { width:13%; }
#zk-equip .zk-grid .zk-c-resumo { width:24%; }
#zk-equip .zk-grid .zk-c-detal  { width:24%; }
#zk-equip .zk-grid textarea { width:100%; box-sizing:border-box; padding:7px 8px; border:1px solid #d3d7d1;
  border-radius:5px; font-size:13px; resize:vertical; min-height:34px; font-family:inherit; line-height:1.35; }
/* Colunas dos painéis (agente/cliente) */
/* Miniaturas de fotos: a altura da linha é sempre definida por elas (padrão fixo) */
.zk-photos { display:flex; flex-wrap:wrap; gap:6px; flex:0 0 auto; }
.zk-photo-thumb { display:block; width:56px; height:56px; border-radius:6px; overflow:hidden;
  border:1px solid #dfe4dc; background:#fafcf8; flex:0 0 auto; box-sizing:border-box; }
.zk-photo-thumb:hover { border-color:#7AC143; }
.zk-photo-thumb img { width:100%; height:100%; object-fit:cover; display:block; }
/* Status/link da Nota Fiscal (XML) do CHAMADO, no cabeçalho do painel
   (cliente e agente) e na tela de editar — link se já tiver sido
   anexada, aviso cinza se não. O nome do arquivo vem num <span> à parte
   (.zk-nf-text) pra truncar com reticências sem cortar o ícone — a
   chave de acesso de uma NF-e tem 44 dígitos, não cabe/não ajuda
   mostrar inteira; o nome completo fica no title (tooltip) do link. */
.zk-nf-status,
.zk-nf-link { display:inline-flex; align-items:center; gap:5px; max-width:100%;
  font-size:12px; font-weight:600; min-width:0; }
.zk-nf-link { color:#2a6ebb; text-decoration:none; }
.zk-nf-link:hover { color:#1d4e85; border-bottom:0; }
.zk-nf-status i, .zk-nf-link i { font-size:15px; flex:0 0 auto; }
.zk-nf-text { overflow:hidden; text-overflow:ellipsis; white-space:nowrap; min-width:0; }
.zk-badge-pend + .zk-badge-pend { margin-left:4px; }
/* Bloco "Problema relatado": texto nunca quebra linha nem estoura a altura da miniatura */
.zk-issue-row { display:flex; align-items:center; gap:10px; height:56px; }
.zk-issue-text { flex:1 1 auto; min-width:0; overflow:hidden; }
.zk-issue-text .zk-issue-line { display:block; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
.zk-table .zk-c-num { width:34px; text-align:center; color:#9aa0a6; }
.zk-table.zk-edit .zk-status-sel { width:100%; max-width:100%; }
/* Contador de caracteres do Resumo do problema (grade de cadastro/edição) */
.zk-c-resumo { position:relative; }
/* Contador de caracteres na MESMA LINHA do cabeçalho da coluna (Resumo /
   Detalhamento-Observação), em vez de uma linha extra dentro da célula —
   não desalinha a altura da linha de dados. */
#zk-equip .zk-grid th .zk-th-count { font-weight:400; font-size:11px; color:#9aa0a6; margin-left:6px; white-space:nowrap; }
#zk-equip .zk-grid th .zk-th-count.zk-count-warn { color:#d99a00; }
#zk-equip .zk-grid th .zk-th-count.zk-count-max { color:#c0392b; }
@media (max-width:768px){ .zk-search{width:100%;} .zk-table-wrap,#zk-equip .zk-grid-wrap{max-height:none;} }
/* Pop-up (lightbox) da foto do equipamento — em vez de abrir em nova aba */
.zk-lightbox { display:none; position:fixed; inset:0; z-index:9999;
  background:rgba(20,22,20,.82); text-align:center; padding:40px 20px; box-sizing:border-box; }
.zk-lightbox-img { max-width:min(90vw,900px); max-height:calc(100vh - 80px);
  border-radius:6px; box-shadow:0 10px 40px rgba(0,0,0,.4); }
.zk-lightbox-close { position:fixed; top:16px; right:24px; color:#fff; font-size:34px;
  line-height:1; cursor:pointer; font-weight:300; }
.zk-lightbox-close:hover { color:#7AC143; }
</style>
CSS;
    echo '<div id="zk-lightbox" class="zk-lightbox">'
        .'<span class="zk-lightbox-close">&times;</span>'
        .'<img class="zk-lightbox-img" src="" alt=""></div>'
        .'<script type="text/javascript">'
        .'(function($){'
        .'$(document).on("click","a.zk-photo-thumb",function(e){'
        .'e.preventDefault();'
        .'$("#zk-lightbox .zk-lightbox-img").attr({src:$(this).attr("href"),alt:$(this).attr("title")||""});'
        .'$("#zk-lightbox").fadeIn(120);'
        .'});'
        .'function zkCloseLightbox(){ $("#zk-lightbox").fadeOut(120); }'
        .'$(document).on("click",".zk-lightbox-close,.zk-lightbox",function(e){ if (e.target===this) zkCloseLightbox(); });'
        .'$(document).on("keyup",function(e){ if (e.key==="Escape") zkCloseLightbox(); });'
        .'})(jQuery);'
        .'</script>';
}

/* ------------------------------------------------------------------ *
 *  Persistência na CRIAÇÃO do ticket (Signal 'ticket.created')
 *  Lê o campo oculto zk_equipments_json enviado pela grade do cliente.
 * ------------------------------------------------------------------ */
function zk_equip_on_ticket_created($ticket, $data = null) {
    if (!$ticket || !method_exists($ticket, 'getId') || !$ticket->getId())
        return;
    $rows = zk_equip_request_rows();
    if (!is_array($rows) || !count($rows))
        return;

    $tid  = (int) $ticket->getId();
    $seq  = 0;
    $max  = 1000; // trava de segurança
    foreach ($rows as $r) {
        if ($seq >= $max) break;
        if (!is_array($r)) continue;
        $modelo   = isset($r['modelo'])       ? trim((string) $r['modelo'])       : '';
        $serie    = isset($r['serie'])        ? trim((string) $r['serie'])        : '';
        $resumo   = isset($r['resumo'])       ? trim((string) $r['resumo'])       : '';
        $detal    = isset($r['detalhamento']) ? trim((string) $r['detalhamento']) : '';
        $photoKey = isset($r['photo_key'])    ? preg_replace('/[^A-Za-z0-9_-]/', '', (string) $r['photo_key']) : '';
        // Revalidação server-side: todos os campos + pelo menos 1 foto são
        // obrigatórios (mesma regra do JS) — linha incompleta é ignorada,
        // mesmo que a requisição tenha contornado a validação do navegador.
        if ($modelo === '' || $serie === '' || $resumo === '' || $detal === ''
                || !zk_equip_photo_present($photoKey))
            continue;
        $seq++;
        $sql = 'INSERT INTO '.zk_equip_table().' SET '
             .'  ticket_id='.db_input($tid)
             .', seq='.db_input($seq)
             .', modelo='.db_input(mb_substr($modelo, 0, 120))
             .', numero_serie='.db_input(mb_substr($serie, 0, 120))
             .', resumo='.db_input(mb_substr($resumo, 0, 255))
             .', detalhamento='.db_input(mb_substr($detal, 0, 200))
             .', status='.db_input(zk_equip_default_status())
             .', pendencia='.db_input(zk_equip_default_pendencia())
             .', created=NOW(), updated=NOW()';
        if (db_query($sql)) {
            $eid = db_insert_id();
            if ($eid && $photoKey !== '')
                zk_equip_save_uploaded_photos($tid, $eid, $photoKey);
        }
    }
    // Nota Fiscal (XML) é do CHAMADO como um todo (não de um equipamento
    // específico) — opcional, tenta salvar 1x só; se não veio nada, ou não
    // for .xml válido, simplesmente não salva nada (não bloqueia a criação).
    zk_save_ticket_nf($tid);
    // Sempre sincroniza a Pendência dos itens recém-criados com o estado
    // da NF (mesmo se não veio nenhuma — nesse caso vira "sem_nf").
    zk_sync_equip_pendencia($tid);
}
Signal::connect('ticket.created', 'zk_equip_on_ticket_created');

/* ZK-EQUIP: nº máximo de fotos por equipamento (mesmo limite validado no
   client-side em open.inc.php/zk-equip-edit.inc.php). O input agora é
   name="zk_equip_photo[photoKey][]" — o JS sempre reconstrói a FileList
   inteira a cada mudança, então os slots chegam compactados a partir de 0
   (0..N-1), nunca com buracos. */
define('ZK_EQUIP_MAX_PHOTOS', 5);

function zk_equip_uploaded_photo($photoKey, $slot) {
    if (empty($_FILES['zk_equip_photo']) || $photoKey === '')
        return null;
    $root = $_FILES['zk_equip_photo'];
    if (!isset($root['name'][$photoKey][$slot]))
        return null;

    return array(
        'name'     => $root['name'][$photoKey][$slot],
        'type'     => $root['type'][$photoKey][$slot],
        'tmp_name' => $root['tmp_name'][$photoKey][$slot],
        'error'    => $root['error'][$photoKey][$slot],
        'size'     => $root['size'][$photoKey][$slot],
    );
}

/* Revalidação server-side de "pelo menos 1 foto": mesma checagem de
   erro/tmp_name usada em zk_equip_save_uploaded_photos(), mas só olha
   (não salva) — usada para decidir se a linha do equipamento pode ser
   aceita antes de gravar qualquer coisa no banco. */
function zk_equip_photo_present($photoKey) {
    if ($photoKey === '')
        return false;
    for ($slot = 0; $slot < ZK_EQUIP_MAX_PHOTOS; $slot++) {
        $file = zk_equip_uploaded_photo($photoKey, $slot);
        if ($file && $file['error'] != UPLOAD_ERR_NO_FILE
                && !$file['error'] && $file['tmp_name'] && is_uploaded_file($file['tmp_name']))
            return true;
    }
    return false;
}

function zk_equip_save_uploaded_photos($ticket_id, $equipment_id, $photoKey) {
    for ($slot = 0; $slot < ZK_EQUIP_MAX_PHOTOS; $slot++) {
        $file = zk_equip_uploaded_photo($photoKey, $slot);
        if (!$file || $file['error'] == UPLOAD_ERR_NO_FILE)
            continue;
        if ($file['error'] || !$file['tmp_name'] || !is_uploaded_file($file['tmp_name']))
            continue;

        $type = '';
        if (extension_loaded('fileinfo')) {
            $finfo = new finfo(FILEINFO_MIME_TYPE);
            $type = (string) $finfo->file($file['tmp_name']);
        }
        if (!$type)
            $type = (string) $file['type'];
        if (stripos($type, 'image/') !== 0)
            continue;

        $file['type'] = $type;
        if (($F = AttachmentFile::upload($file, 'T'))) {
            zk_file_shield($F); // protege do deleteOrphans do cron
            db_query('INSERT INTO '.zk_equip_file_table().' SET '
                .' ticket_id='.db_input((int) $ticket_id)
                .', equipment_id='.db_input((int) $equipment_id)
                .', file_id='.db_input((int) $F->getId())
                .', slot='.db_input((int) $slot)
                .', created=NOW()');
        }
    }
}

/* ------------------------------------------------------------------ *
 *  Nota Fiscal (XML) do CHAMADO — 1 anexo por ticket (não por
 *  equipamento: um chamado pode ter vários itens, mas normalmente só
 *  uma NF/coleta). Tabela própria (ost_zk_ticket_file), fora da tabela
 *  de fotos por item. Opcional; só aceita .xml de verdade: extensão E
 *  (quando disponível) MIME — deixado explícito no pedido do usuário
 *  ("vamos fazer o upload apenas de XML").
 * ------------------------------------------------------------------ */
function zk_ticket_file_table() { return TABLE_PREFIX.'zk_ticket_file'; }

/* ------------------------------------------------------------------ *
 *  ARQUIVOS COMPARTILHADOS — o osTicket DEDUPLICA ost_file por
 *  hash+tamanho (AttachmentFile::create): o MESMO file_id pode ser,
 *  ao mesmo tempo, foto de equipamento, NF/Declaração e anexo de
 *  thread — inclusive de OUTROS tickets. Duas regras obrigatórias:
 *  1. NUNCA apagar um AttachmentFile sem contar as referências
 *     (bug real 2026-07-03: lixeira da NF apagou o arquivo que também
 *     era a foto de equipamento de 2 tickets).
 *  2. Blindar os arquivos do módulo contra o cron do core
 *     (AttachmentFile::deleteOrphans apaga diariamente arquivos ft='T'
 *     sem vínculo em ost_attachment — os nossos vivem em tabelas
 *     próprias e são invisíveis pra ele): ft vira 'Z' no upload.
 * ------------------------------------------------------------------ */
function zk_file_refcount($file_id) {
    $fid = (int) $file_id;
    $n = 0;
    foreach (array(
        'SELECT COUNT(*) AS c FROM '.TABLE_PREFIX.'attachment WHERE file_id='.db_input($fid),
        'SELECT COUNT(*) AS c FROM '.zk_ticket_file_table().' WHERE file_id='.db_input($fid),
        'SELECT COUNT(*) AS c FROM '.zk_equip_file_table().' WHERE file_id='.db_input($fid),
    ) as $sql) {
        if (($r = db_query($sql)) && ($row = db_fetch_array($r)))
            $n += (int) $row['c'];
    }
    return $n;
}

// Apaga o AttachmentFile SÓ quando ninguém mais o referencia (chamar
// DEPOIS de remover a linha de vínculo do próprio módulo).
function zk_file_delete_if_unused($file_id) {
    if (zk_file_refcount($file_id) > 0)
        return false;
    if ($file = AttachmentFile::lookup((int) $file_id))
        return (bool) $file->delete();
    return false;
}

// Blindagem contra o deleteOrphans do core (só mexe se ainda for 'T').
function zk_file_shield($F) {
    if ($F && $F->ft === 'T') {
        $F->ft = 'Z';
        $F->save();
    }
}

function zk_ticket_files($ticket_id, $kind = null) {
    $tid  = (int) $ticket_id;
    $rows = array();
    $sql  = 'SELECT tf.*, f.name, f.type, f.size'
          . ' FROM '.zk_ticket_file_table().' tf'
          . ' INNER JOIN '.FILE_TABLE.' f ON (f.id = tf.file_id)'
          . ' WHERE tf.ticket_id='.db_input($tid);
    if ($kind !== null)
        $sql .= ' AND tf.kind='.db_input($kind);
    $sql .= ' ORDER BY tf.id';
    $res = db_query($sql);
    if ($res)
        while ($r = db_fetch_array($res))
            $rows[] = $r;
    return $rows;
}

/* Link(s) de download da NF do chamado — usado nos painéis (cliente e
   agente) e na tela de editar equipamentos. Sempre retorna algo visível
   (link se tiver, ou o aviso "não anexada"), pra deixar claro o estado. */
function zk_ticket_nf_html($ticket_id) {
    $none = '<span class="zk-nf-status zk-muted"><i class="icon-file-text-alt"></i> '
          . '<span class="zk-nf-text">'.__('Nota Fiscal: não anexada').'</span></span>';
    $files = zk_ticket_files($ticket_id, 'nf');
    if (!$files)
        return $none;
    $h = '';
    foreach ($files as $f) {
        $file = AttachmentFile::lookup((int) $f['file_id']);
        if (!$file)
            continue;
        $url = Format::htmlchars($file->getDownloadUrl(array('disposition' => 'attachment')));
        $label = __('Nota Fiscal').' — '.Format::htmlchars($f['name']);
        // Nome do arquivo (texto) fica num <span> à parte — é ele que trunca
        // com reticências quando é muito longo (chave de acesso de NF-e tem
        // 44 dígitos); o nome completo continua no title (tooltip) do link.
        $h .= '<a class="zk-nf-link no-pjax" href="'.$url.'" title="'.Format::htmlchars($f['name']).'">'
            . '<i class="icon-file-text-alt"></i> <span class="zk-nf-text">'.$label.'</span></a> ';
    }
    return $h !== '' ? $h : $none;
}

function zk_uploaded_ticket_nf() {
    if (empty($_FILES['zk_ticket_nf']))
        return null;
    $f = $_FILES['zk_ticket_nf'];
    if (!isset($f['name']) || $f['error'] == UPLOAD_ERR_NO_FILE)
        return null;
    return $f;
}

function zk_save_ticket_nf($ticket_id) {
    $file = zk_uploaded_ticket_nf();
    if (!$file || $file['error'] == UPLOAD_ERR_NO_FILE)
        return false;
    if ($file['error'] || !$file['tmp_name'] || !is_uploaded_file($file['tmp_name']))
        return false;

    // Extensão precisa ser .xml — checagem explícita, não depende só do
    // "accept" do <input>, que é só uma sugestão pro seletor de arquivos.
    if (strtolower(pathinfo((string) $file['name'], PATHINFO_EXTENSION)) !== 'xml')
        return false;

    $type = '';
    if (extension_loaded('fileinfo')) {
        $finfo = new finfo(FILEINFO_MIME_TYPE);
        $type = (string) $finfo->file($file['tmp_name']);
    }
    // NF-e às vezes é detectada como text/xml, application/xml ou até
    // text/plain (arquivo sem BOM/declaração). A extensão .xml já foi
    // conferida acima; o MIME aqui só barra o caso óbvio de um arquivo
    // binário qualquer renomeado pra .xml.
    if ($type && stripos($type, 'xml') === false && stripos($type, 'text/plain') === false)
        return false;

    $file['type'] = $type ?: 'text/xml';
    if (($F = AttachmentFile::upload($file, 'T'))) {
        zk_file_shield($F); // protege do deleteOrphans do cron
        // "Trocar" de verdade: só 1 NF por chamado. Remove a(s) anterior(es)
        // só DEPOIS que a nova já foi validada e salva com sucesso — se a
        // nova falhasse antes disso, a antiga continuaria intacta.
        zk_delete_ticket_nf($ticket_id);
        db_query('INSERT INTO '.zk_ticket_file_table().' SET '
            .' ticket_id='.db_input((int) $ticket_id)
            .', file_id='.db_input((int) $F->getId())
            .', kind='.db_input('nf')
            .', errors=NULL'
            .', created=NOW()');
        // Verificação AUTOMÁTICA no upload: valida o XML na hora — o
        // resultado (erros ou "validado") já aparece sem o cliente
        // precisar clicar em "Verificar XML". Grava os erros na linha
        // recém-inserida e sincroniza a Pendência dos equipamentos.
        zk_verify_ticket_nf($ticket_id);
        return true;
    }
    return false;
}

/* Remove a(s) Nota(s) Fiscal(is) já anexada(s) ao chamado — usada tanto
   pelo botão "Apagar" explícito quanto internamente por zk_save_ticket_nf()
   pra trocar. Deleta o anexo de verdade (AttachmentFile::delete(), libera
   o armazenamento), não só o vínculo na tabela — evita lixo órfão. */
function zk_delete_ticket_nf($ticket_id) {
    $files = zk_ticket_files((int) $ticket_id, 'nf');
    $n = 0;
    foreach ($files as $f) {
        db_query('DELETE FROM '.zk_ticket_file_table().' WHERE id='.db_input((int) $f['id']));
        // Só apaga o arquivo físico se NINGUÉM mais o referencia (o
        // osTicket deduplica por hash — ver zk_file_refcount).
        zk_file_delete_if_unused((int) $f['file_id']);
        $n++;
    }
    if ($n)
        zk_sync_equip_pendencia($ticket_id);
    return $n;
}

/* ------------------------------------------------------------------ *
 *  DECLARAÇÃO DE CONTEÚDO (kind='dc') — cliente FINAL que não emite
 *  NF-e. É o formulário dos Correios que acompanha o pacote no lugar
 *  da NF; com ela, o envio é OBRIGATORIAMENTE pelos CORREIOS (único
 *  meio que transporta equipamento sem Nota Fiscal). Aceita PDF/foto.
 * ------------------------------------------------------------------ */
// "Modo cliente final": tem Declaração de Conteúdo e NÃO tem NF —
// se uma NF for anexada depois, as regras de NF voltam a valer.
function zk_ticket_dc_mode($ticket_id) {
    return zk_ticket_files((int) $ticket_id, 'dc')
        && !zk_ticket_files((int) $ticket_id, 'nf');
}

function zk_ticket_dc_html($ticket_id) {
    $files = zk_ticket_files((int) $ticket_id, 'dc');
    if (!$files)
        return '';
    $h = '';
    foreach ($files as $f) {
        $file = AttachmentFile::lookup((int) $f['file_id']);
        if (!$file)
            continue;
        $url = Format::htmlchars($file->getDownloadUrl(array('disposition' => 'attachment')));
        $label = __('Declaração de Conteúdo').' — '.Format::htmlchars($f['name']);
        $h .= '<a class="zk-nf-link no-pjax" href="'.$url.'" title="'.Format::htmlchars($f['name']).'">'
            . '<i class="icon-file"></i> <span class="zk-nf-text">'.$label.'</span></a> ';
    }
    return $h;
}

function zk_uploaded_ticket_dc() {
    if (empty($_FILES['zk_ticket_dc']))
        return null;
    $f = $_FILES['zk_ticket_dc'];
    if (!isset($f['name']) || $f['error'] == UPLOAD_ERR_NO_FILE)
        return null;
    return $f;
}

function zk_save_ticket_dc($ticket_id) {
    $file = zk_uploaded_ticket_dc();
    if (!$file || $file['error'] == UPLOAD_ERR_NO_FILE)
        return false;
    if ($file['error'] || !$file['tmp_name'] || !is_uploaded_file($file['tmp_name']))
        return false;

    // PDF ou foto do formulário preenchido (mesma checagem dupla da NF:
    // extensão explícita + MIME pra barrar binário renomeado).
    $ext = strtolower(pathinfo((string) $file['name'], PATHINFO_EXTENSION));
    if (!in_array($ext, array('pdf', 'jpg', 'jpeg', 'png'), true))
        return false;
    $type = '';
    if (extension_loaded('fileinfo')) {
        $finfo = new finfo(FILEINFO_MIME_TYPE);
        $type = (string) $finfo->file($file['tmp_name']);
    }
    if ($type && stripos($type, 'pdf') === false && stripos($type, 'image/') === false)
        return false;

    $file['type'] = $type ?: ($ext === 'pdf' ? 'application/pdf' : 'image/jpeg');
    if (($F = AttachmentFile::upload($file, 'T'))) {
        zk_file_shield($F); // protege do deleteOrphans do cron
        // 1 Declaração por chamado — a nova substitui a anterior (só
        // depois de salva com sucesso, como na NF).
        zk_delete_ticket_dc($ticket_id);
        db_query('INSERT INTO '.zk_ticket_file_table().' SET '
            .' ticket_id='.db_input((int) $ticket_id)
            .', file_id='.db_input((int) $F->getId())
            .', kind='.db_input('dc')
            .', errors=NULL'
            .', created=NOW()');
        zk_sync_equip_pendencia($ticket_id);
        return true;
    }
    return false;
}

function zk_delete_ticket_dc($ticket_id) {
    $files = zk_ticket_files((int) $ticket_id, 'dc');
    $n = 0;
    foreach ($files as $f) {
        db_query('DELETE FROM '.zk_ticket_file_table().' WHERE id='.db_input((int) $f['id']));
        // Refcount antes de apagar de verdade (arquivo pode ser compartilhado)
        zk_file_delete_if_unused((int) $f['file_id']);
        $n++;
    }
    if ($n)
        zk_sync_equip_pendencia($ticket_id);
    return $n;
}

/* ------------------------------------------------------------------ *
 *  Sincronização automática Pendência <- estado da NF e do Envio.
 *  A NF e o Envio são do CHAMADO, mas a Pendência é por EQUIPAMENTO —
 *  então todo equipamento do chamado reflete o mesmo estado. A NF tem
 *  prioridade: só quando ela está resolvida (verificada e sem erro) é
 *  que a pendência de envio aparece — um passo de cada vez pro cliente.
 *  Só mexe nos equipamentos cuja pendência atual é "gerenciada" (vazia
 *  ou uma das automáticas) — nunca sobrescreve algo escolhido
 *  manualmente pelo agente (ex.: "aguardando_rastreio").
 * ------------------------------------------------------------------ */
function zk_sync_equip_pendencia($ticket_id) {
    $tid = (int) $ticket_id;
    $newPend = zk_ticket_nf_pendencia($tid);
    if ($newPend === '')
        $newPend = zk_ticket_envio_pendencia($tid);
    $managed = zk_equip_pendencias_managed();
    $inList  = implode(',', array_map('db_input', $managed));
    db_query('UPDATE '.zk_equip_table().' SET pendencia='.db_input($newPend)
        .' WHERE ticket_id='.db_input($tid)
        .' AND pendencia IN ('.$inList.')');
}

/* Deriva a chave de pendência (das 3 controladas por NF) a partir do
   estado atual da NF do chamado: sem arquivo / não verificada (errors
   ainda NULL) / com erro (errors não vazio) / OK (errors === ''). */
function zk_ticket_nf_pendencia($ticket_id) {
    $files = zk_ticket_files((int) $ticket_id, 'nf');
    if (!$files) {
        // Cliente final (pessoa física, não emite NF-e): a Declaração de
        // Conteúdo substitui a NF como documentação do envio — e o envio
        // fica travado em CORREIOS (reforço em zk_save_ticket_envio).
        if (zk_ticket_files((int) $ticket_id, 'dc'))
            return '';
        return 'sem_nf';
    }
    $errors = $files[0]['errors'];
    if ($errors === null)
        return 'nf_nao_verificada';
    if ($errors === '')
        return ''; // verificada, sem erro -> sem pendência
    return 'nf_com_erro';
}

/* Lista de erros da última verificação (uma linha por erro) — usada nos
   painéis quando a pendência é "nf_com_erro". Retorna array vazio se
   não tem NF, ainda não foi verificada, ou passou sem erro. */
function zk_ticket_nf_error_list($ticket_id) {
    $files = zk_ticket_files((int) $ticket_id, 'nf');
    if (!$files || $files[0]['errors'] === null || $files[0]['errors'] === '')
        return array();
    return array_filter(array_map('trim', explode("\n", $files[0]['errors'])));
}

/* Nome amigável dos campos do destinatário da NF-e (pro cliente não
   precisar decifrar "enderDest.xLgr"). Caminho desconhecido volta cru. */
function zk_nfe_campo_label($path) {
    static $map = array(
        'CNPJ'              => 'CNPJ',
        'xNome'             => 'Razão social',
        'enderDest.xLgr'    => 'Endereço (rua)',
        'enderDest.nro'     => 'Número',
        'enderDest.xCpl'    => 'Complemento',
        'enderDest.xBairro' => 'Bairro',
        'enderDest.cMun'    => 'Cód. do município (IBGE)',
        'enderDest.xMun'    => 'Cidade',
        'enderDest.UF'      => 'UF',
        'enderDest.CEP'     => 'CEP',
        'enderDest.cPais'   => 'Cód. do país',
        'enderDest.xPais'   => 'País',
        'enderDest.fone'    => 'Telefone',
        'indIEDest'         => 'Indicador de IE',
        'IE'                => 'Inscrição Estadual',
    );
    return isset($map[$path]) ? $map[$path] : $path;
}

/* Erros da NF em formato de TABELA comparativa (Campo | Está na NF |
   Deveria estar) — muito mais legível pra corrigir a nota do que as
   frases corridas. As frases continuam sendo o formato ARMAZENADO (e o
   dos logs da timeline); aqui elas são parseadas pelos padrões fixos dos
   sprintf de zk_validate_nfe_xml. O que não casar com nenhum padrão cai
   numa lista simples abaixo da tabela (nada se perde). */
function zk_ticket_nf_errors_html($ticket_id) {
    $errors = zk_ticket_nf_error_list($ticket_id);
    if (!$errors)
        return '';
    $rows = $others = array();
    foreach ($errors as $e) {
        if (preg_match('/^Destinatário: "(.+?)" está "(.*?)", deveria ser "(.*?)"\.$/u', $e, $m))
            $rows[] = array(zk_nfe_campo_label($m[1]), $m[2], $m[3]);
        elseif (preg_match('/^Destinatário: campo "(.+?)" ausente no XML \(esperado "(.*?)"\)\.$/u', $e, $m))
            $rows[] = array(zk_nfe_campo_label($m[1]), null, $m[2]);
        elseif (preg_match('/^CFOP do item (\d+) é "(.*?)" — só é permitido (.+?)\.$/u', $e, $m))
            $rows[] = array('CFOP (item '.$m[1].')', $m[2], $m[3]);
        elseif (preg_match('/^Imposto destacado encontrado \((\w+) = (.*?)\) — .+$/u', $e, $m))
            $rows[] = array('Imposto ('.$m[1].')', $m[2], __('zerado — NF de remessa não pode ter imposto destacado'));
        else
            $others[] = $e;
    }
    $h = '';
    if ($rows) {
        $h .= '<div class="zk-nf-errors-scroll"><table class="zk-nf-errors-table"><thead><tr>'
            . '<th>'.__('Campo').'</th>'
            . '<th><i class="icon-remove"></i> '.__('Está na NF').'</th>'
            . '<th><i class="icon-ok"></i> '.__('Deveria estar').'</th>'
            . '</tr></thead><tbody>';
        foreach ($rows as $r) {
            $h .= '<tr><td class="zk-nf-campo">'.Format::htmlchars($r[0]).'</td>'
                . '<td class="zk-nf-est">'.($r[1] === null
                    ? '<i>'.__('ausente no XML').'</i>' : Format::htmlchars($r[1])).'</td>'
                . '<td class="zk-nf-esp">'.Format::htmlchars($r[2]).'</td></tr>';
        }
        $h .= '</tbody></table></div>';
    }
    if ($others) {
        $h .= '<ul class="zk-nf-errors">';
        foreach ($others as $e)
            $h .= '<li>'.Format::htmlchars($e).'</li>';
        $h .= '</ul>';
    }
    return $h;
}

/* ------------------------------------------------------------------ *
 *  Dica "como emitir a NF" — botão (?) ao lado da área de Nota Fiscal
 *  que abre um balão com os dados que a verificação do XML confere
 *  (destinatário, CFOP, sem imposto destacado) + o Complemento do
 *  endereço (não validado, mas necessário na NF). O conteúdo é montado
 *  a partir das MESMAS funções usadas pela validação — se a regra mudar
 *  lá, a dica muda junto, sem risco de divergir.
 * ------------------------------------------------------------------ */
function zk_nf_dica_html() {
    static $n = 0; $n++;
    $id = 'zkNfDica'.$n;
    $d  = zk_nfe_destinatario_esperado();
    $cnpj = preg_replace('/^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$/', '$1.$2.$3/$4-$5', $d['CNPJ']);
    $cep  = preg_replace('/^(\d{5})(\d{3})$/', '$1-$2', $d['enderDest.CEP']);
    $fone = preg_replace('/^(\d{2})(\d{4})(\d{4})$/', '($1) $2-$3', zk_nfe_telefone());
    $cfops = zk_nfe_cfops_permitidos();
    ob_start();
    ?>
  <span class="zk-nf-dica-wrap">
    <button type="button" class="zk-nf-dica-btn" data-zk-dica="<?php echo $id; ?>"
            title="<?php echo __('Como emitir a Nota Fiscal'); ?>">?</button>
    <span class="zk-nf-dica-pop" id="<?php echo $id; ?>" style="display:none">
      <b class="zk-nf-dica-title"><?php echo __('Dados para emitir a Nota Fiscal (remessa para conserto)'); ?></b>
      <span class="zk-nf-dica-sec"><?php echo __('Destinatário'); ?></span>
      <ul>
        <li><?php echo __('Razão social'); ?>: <b><?php echo Format::htmlchars($d['xNome']); ?></b></li>
        <li>CNPJ: <b><?php echo Format::htmlchars($cnpj); ?></b></li>
        <li><?php echo __('Inscrição Estadual'); ?>: <b><?php echo Format::htmlchars($d['IE']); ?></b> (<?php echo __('contribuinte do ICMS'); ?>)</li>
        <li><?php echo __('Endereço'); ?>: <b><?php echo Format::htmlchars($d['enderDest.xLgr'].', '.$d['enderDest.nro']); ?></b>
            — <?php echo __('Complemento'); ?>: <b><?php echo Format::htmlchars(zk_nfe_complemento_endereco()); ?></b></li>
        <li><?php echo __('Bairro'); ?>: <b><?php echo Format::htmlchars($d['enderDest.xBairro']); ?></b>
            — <b><?php echo Format::htmlchars($d['enderDest.xMun'].'/'.$d['enderDest.UF']); ?></b>
            — CEP: <b><?php echo Format::htmlchars($cep); ?></b></li>
        <li><?php echo __('Telefone'); ?>: <b><?php echo Format::htmlchars($fone); ?></b></li>
      </ul>
      <span class="zk-nf-dica-sec">CFOP</span>
      <ul>
        <li><b><?php echo Format::htmlchars($cfops[0]); ?></b> (<?php echo __('remetente de Minas Gerais'); ?>)
            <?php echo __('ou'); ?> <b><?php echo Format::htmlchars($cfops[1]); ?></b> (<?php echo __('remetente de outro estado'); ?>)
            — <?php echo __('remessa para conserto'); ?></li>
      </ul>
      <span class="zk-nf-dica-sec"><?php echo __('Impostos'); ?></span>
      <ul>
        <li><?php echo __('Nenhum imposto destacado (ICMS, IPI, PIS, COFINS etc. zerados) — a remessa para conserto é operação isenta.'); ?></li>
      </ul>
    </span>
  </span>
    <?php
    if ($n === 1) {
        // Handler único (delegado) pra todas as instâncias da página:
        // abre/fecha no clique do (?), fecha ao clicar fora.
        ?>
  <script type="text/javascript">
  document.addEventListener('click', function(e){
    var btn = e.target.closest ? e.target.closest('.zk-nf-dica-btn') : null;
    var pops = document.querySelectorAll('.zk-nf-dica-pop');
    if (btn) {
      var pop = document.getElementById(btn.getAttribute('data-zk-dica'));
      var show = pop.style.display === 'none';
      pops.forEach(function(p){ p.style.display = 'none'; });
      if (show) pop.style.display = 'block';
      e.preventDefault();
    } else if (!(e.target.closest && e.target.closest('.zk-nf-dica-pop'))) {
      pops.forEach(function(p){ p.style.display = 'none'; });
    }
  });
  </script>
        <?php
    }
    return ob_get_clean();
}

/* ------------------------------------------------------------------ *
 *  ENVIO DO PRODUTO (transportadora + rastreio) — por CHAMADO, como a
 *  NF. O cliente informa DEPOIS de criar o chamado (nasce vazio de
 *  propósito: é uma pendência que ele resolve quando despachar o
 *  equipamento). CORREIOS exige código de rastreio; O PRÓPRIO / OUTRA
 *  não têm rastreio.
 *  Tabela: ost_zk_ticket_envio (própria, imune a upgrade).
 * ------------------------------------------------------------------ */
function zk_ticket_envio_table() { return TABLE_PREFIX.'zk_ticket_envio'; }

function zk_envio_transportadoras() {
    return array(
        'correios'  => 'CORREIOS',
        'o_proprio' => 'O PRÓPRIO',
        'outra'     => 'OUTRA',
    );
}
function zk_envio_transportadora_label($key) {
    $t = zk_envio_transportadoras();
    return isset($t[$key]) ? $t[$key] : '';
}

/* Estado atual do envio do chamado — sempre retorna as 3 chaves
   ('' = ainda não informado; confirmado = null enquanto o cliente não
   clicar em "Confirmar envio"). */
function zk_ticket_envio($ticket_id) {
    $res = db_query('SELECT transportadora, rastreio, confirmado FROM '.zk_ticket_envio_table()
                   .' WHERE ticket_id='.db_input((int) $ticket_id));
    if ($res && ($r = db_fetch_array($res)))
        return array('transportadora' => (string) $r['transportadora'],
                     'rastreio'       => (string) $r['rastreio'],
                     'confirmado'     => $r['confirmado']);
    return array('transportadora' => '', 'rastreio' => '', 'confirmado' => null);
}

/* Salva/atualiza o envio. Regras: transportadora precisa ser uma das
   chaves válidas; CORREIOS exige rastreio não-vazio; nas demais o
   rastreio é descartado (não se aplica). Retorna null em caso de
   sucesso ou uma mensagem de erro (validação também existe no JS, aqui
   é a garantia server-side). */
function zk_save_ticket_envio($ticket_id, $transportadora, $rastreio) {
    $tid = (int) $ticket_id;
    $t   = trim((string) $transportadora);
    $r   = trim((string) $rastreio);
    // O envio só pode ser informado com a NF validada (verificada e sem
    // erro) — senão o cliente despacha o produto sem NF. O form nem
    // aparece antes disso; este é o reforço server-side.
    if (zk_ticket_nf_pendencia($tid) !== '')
        return __('A Nota Fiscal precisa estar validada antes de informar o envio.');
    // Depois de confirmado, os dados do envio ficam travados (são o
    // registro do que foi despachado) — mudanças só via agente.
    $atual = zk_ticket_envio($tid);
    if ($atual['confirmado'])
        return __('O envio já foi confirmado — os dados não podem mais ser alterados.');
    // Cliente final (Declaração de Conteúdo, sem NF): envio SOMENTE pelos
    // CORREIOS — único meio que transporta equipamento sem Nota Fiscal.
    if (zk_ticket_dc_mode($tid) && $t !== 'correios')
        return __('Com Declaração de Conteúdo (cliente final), o envio deve ser obrigatoriamente pelos CORREIOS.');
    $valid = zk_envio_transportadoras();
    if (!isset($valid[$t]))
        return __('Selecione a transportadora.');
    if ($t === 'correios' && $r === '')
        return __('Informe o código de rastreio dos CORREIOS.');
    $r = ($t === 'correios') ? mb_strtoupper($r) : '';
    db_query('INSERT INTO '.zk_ticket_envio_table().' SET '
        .'  ticket_id='.db_input($tid)
        .', transportadora='.db_input($t)
        .', rastreio='.db_input(mb_substr($r, 0, 64))
        .', updated=NOW()'
        .' ON DUPLICATE KEY UPDATE '
        .'  transportadora='.db_input($t)
        .', rastreio='.db_input(mb_substr($r, 0, 64))
        .', updated=NOW()');
    zk_sync_equip_pendencia($tid);
    return null;
}

/* Deriva a chave de pendência do envio, em 2 degraus:
   - não informado (sem transportadora, ou CORREIOS sem rastreio);
   - informado mas ainda não CONFIRMADO (o cliente escolheu como vai
     enviar, mas ainda não clicou em "Confirmar envio" — ou seja, o
     produto pode ainda não ter sido despachado de fato);
   - '' = informado e confirmado (produto a caminho). */
function zk_ticket_envio_pendencia($ticket_id) {
    $e = zk_ticket_envio($ticket_id);
    if ($e['transportadora'] === '')
        return 'envio_nao_informado';
    if ($e['transportadora'] === 'correios' && trim($e['rastreio']) === '')
        return 'envio_nao_informado';
    if (!$e['confirmado'])
        return 'envio_nao_confirmado';
    return '';
}

/* "Confirmar envio" — o cliente declara que o produto foi de fato
   despachado. Grava a data/hora, trava os dados do envio e muda o
   STATUS do chamado para "Enviado". Retorna null em caso de sucesso
   ou mensagem de erro. */
function zk_confirm_ticket_envio($ticket_id) {
    $tid = (int) $ticket_id;
    if (zk_ticket_nf_pendencia($tid) !== '')
        return __('A Nota Fiscal precisa estar validada antes de confirmar o envio.');
    $e = zk_ticket_envio($tid);
    if ($e['transportadora'] === ''
            || ($e['transportadora'] === 'correios' && trim($e['rastreio']) === ''))
        return __('Informe a transportadora (e o rastreio, se CORREIOS) antes de confirmar o envio.');
    if ($e['confirmado'])
        return __('O envio já foi confirmado.');
    db_query('UPDATE '.zk_ticket_envio_table().' SET confirmado=NOW()'
        .' WHERE ticket_id='.db_input($tid));
    zk_sync_equip_pendencia($tid);
    // Produto despachado → chamado sai de "Solicitado" e vira "Enviado".
    try { zk_ticket_set_status_enviado($tid); }
    catch (Throwable $ex) { /* status é cosmético aqui — não bloqueia a confirmação */ }
    return null;
}

/* Muda o status do CHAMADO para "Enviado" (registro criado em
   ost_ticket_status pra este fluxo, state=open). Lookup por nome pra
   não depender de id fixo entre instalações. Ticket::setStatus() cuida
   do evento na timeline e da sincronização da listagem (__cdata). */
/* Aplica um status DO CICLO ZK pelo NOME (não depende de id fixo entre
   instalações). Idempotente. Usa Ticket::setStatus() (API nativa:
   registra o evento na timeline e sincroniza a listagem sozinha). */
function zk_ticket_set_status_by_name($ticket_id, $name) {
    $status = TicketStatus::lookup(array('name' => $name));
    if (!$status)
        return false;
    $ticket = ($ticket_id instanceof Ticket) ? $ticket_id : Ticket::lookup((int) $ticket_id);
    if (!$ticket)
        return false;
    if ($ticket->getStatusId() == $status->getId())
        return true;
    return (bool) $ticket->setStatus($status);
}

function zk_ticket_set_status_enviado($ticket_id) {
    return zk_ticket_set_status_by_name($ticket_id, 'Enviado');
}

/* Muda o status do CHAMADO para "Resolvido" quando TODOS os equipamentos
   chegam a um status "done" (Concluído/Cancelado — ver zk_equip_statuses).
   Chamada pelo painel do agente (scp/zk-equip.php) depois de salvar as
   mudanças de status dos equipamentos. Idempotente e silenciosa: chamado
   sem equipamento, sem chamado, ou já fechado (Resolvido/Encerrado/
   Arquivados/Deletado) simplesmente não faz nada — não reabre nem some
   com o status do agente ao reverter um equipamento pra uma etapa
   anterior (isso é decisão manual do agente, fora do escopo daqui). */
function zk_ticket_set_status_resolvido($ticket_id) {
    $ticket = ($ticket_id instanceof Ticket) ? $ticket_id : Ticket::lookup((int) $ticket_id);
    if (!$ticket || $ticket->isClosed())
        return false;
    $stats = zk_equip_stats($ticket->getId());
    if (!$stats['total'] || $stats['done'] !== $stats['total'])
        return false;
    return zk_ticket_set_status_by_name($ticket, 'Resolvido');
}

/* ------------------------------------------------------------------ *
 *  NOTIFICAÇÕES AO CLIENTE
 *  1. Toda TROCA DE STATUS do chamado -> e-mail direto com a identidade
 *     ZKTeco (gancho no fim de Ticket::setStatus — patch demarcado).
 *  2. Mudanças de STATUS/LAUDO dos EQUIPAMENTOS (painel do agente) ->
 *     UMA resposta consolidada na thread (vira "história" visível no
 *     cartão Mensagens do cliente) — o postReply já dispara o e-mail
 *     com o template bonito (ticket.reply) sozinho.
 * ------------------------------------------------------------------ */

// Link do chamado pro cliente (com auth token quando habilitado)
function zk_ticket_client_link($ticket) {
    global $cfg;
    try {
        $owner = $ticket->getOwner();
        if ($owner && ($l = $owner->getTicketLink()))
            return $l;
    } catch (Throwable $e) { /* cai no fallback */ }
    return rtrim((string) ($cfg ? $cfg->getBaseUrl() : ''), '/').'/tickets.php?id='.$ticket->getId();
}

/* Envelope HTML dos e-mails DIRETOS do módulo — mesmo layout dos
   templates redesenhados no banco (tabelas + CSS inline, Gmail/Outlook).
   Os e-mails de thread (respostas) usam os templates do banco. */
function zk_mail_zkteco($inner, $ticketNumber = '', $link = '') {
    $ref = '';
    if ($ticketNumber !== '') {
        $btn = $link !== ''
            ? '<td align="right" style="padding:10px 14px;">'
              .'<a href="'.Format::htmlchars($link).'" style="display:inline-block;background-color:#7AC143;color:#ffffff;text-decoration:none;font-weight:bold;font-size:13px;padding:11px 22px;border-radius:7px;font-family:Arial,Helvetica,sans-serif;">Acompanhar meu chamado</a></td>'
            : '';
        $ref = '<tr><td style="background-color:#ffffff;padding:0 30px 24px;font-family:Arial,Helvetica,sans-serif;">'
             .'<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#f5f7f4;border:1px solid #e3e6e2;border-radius:8px;"><tr>'
             .'<td style="padding:14px 20px;font-size:13px;color:#6b716c;">Chamado <b style="color:#474B4F;">#'.Format::htmlchars($ticketNumber).'</b></td>'
             .$btn.'</tr></table></td></tr>';
    }
    return '<div style="margin:0;padding:26px 8px;background-color:#eff1ed;">'
        .'<table role="presentation" align="center" width="100%" cellpadding="0" cellspacing="0" border="0" style="max-width:600px;margin:0 auto;">'
        .'<tr><td style="background-color:#474B4F;border-radius:10px 10px 0 0;padding:20px 30px;font-family:Arial,Helvetica,sans-serif;">'
        .'<span style="font-size:21px;font-weight:bold;color:#ffffff;letter-spacing:.5px;">ZK<span style="color:#7AC143;">Teco</span></span>'
        .'<span style="display:block;font-size:11px;color:#b9bfba;letter-spacing:2px;text-transform:uppercase;padding-top:4px;">Central de Manuten&ccedil;&atilde;o</span>'
        .'</td></tr>'
        .'<tr><td style="height:4px;background-color:#7AC143;font-size:0;line-height:0;">&nbsp;</td></tr>'
        .'<tr><td style="background-color:#ffffff;padding:28px 30px 20px;font-family:Arial,Helvetica,sans-serif;font-size:14px;line-height:1.6;color:#474B4F;">'
        .$inner.'</td></tr>'
        .$ref
        .'<tr><td style="background-color:#ffffff;border-radius:0 0 10px 10px;font-size:0;line-height:0;height:6px;">&nbsp;</td></tr>'
        .'<tr><td style="padding:16px 10px 6px;text-align:center;font-family:Arial,Helvetica,sans-serif;font-size:11.5px;color:#9aa09b;line-height:1.6;">'
        .'Para responder, basta <b style="color:#8a8f8a;">responder a este e-mail</b> &mdash; sua mensagem entra direto no chamado.<br />'
        .'Portal oficial de manuten&ccedil;&atilde;o &middot; Pioneira em solu&ccedil;&otilde;es de seguran&ccedil;a biom&eacute;trica</td></tr>'
        .'</table></div>';
}

/* E-mail de troca de status do CHAMADO. Chamada pelo patch demarcado no
   fim de Ticket::setStatus() — só age em chamados com equipamentos. */
function zk_notify_status_change($ticket, $status) {
    global $cfg;
    if (!$ticket || !$ticket->getId() || !zk_equip_count((int) $ticket->getId()))
        return false;
    $email = ($d = $ticket->getDept()) ? $d->getEmail() : null;
    if (!$email && $cfg)
        $email = $cfg->getDefaultEmail();
    $owner = $ticket->getOwner();
    if (!$email || !$owner)
        return false;

    $stName  = (string) ($status->getLocalName() ?: $status->getName());
    $isClosed = in_array($status->getState(), array('closed', 'archived'), true);
    // texto de apoio por etapa do ciclo ZK (genérico para os demais)
    $apoio = array(
        'Solicitado' => 'Sua solicitação está registrada — siga os próximos passos no portal (Nota Fiscal e envio).',
        'Enviado'    => 'Recebemos a confirmação do envio. Assim que o produto chegar na ZKTeco, avisamos por aqui.',
        'Recebido'   => 'Seu produto chegou na ZKTeco e está com a equipe técnica. Abra o chamado para acompanhar o status por equipamento.',
        'Resolvido'  => 'O atendimento foi concluído. Qualquer dúvida, é só responder este e-mail.',
        'Encerrado'  => 'O chamado foi encerrado. Se precisar de algo, basta responder este e-mail.',
    );
    $extra = isset($apoio[$status->getName()])
        ? $apoio[$status->getName()]
        : 'Acompanhe os detalhes abrindo o chamado no portal.';

    $inner = '<p style="margin:0 0 6px;font-size:16px;"><b>Ol&aacute;, '
        .Format::htmlchars((string) $ticket->getName()->getFirst()).'!</b></p>'
        .'<p style="margin:0 0 12px;">O status do seu chamado foi atualizado para:</p>'
        .'<p style="margin:0 0 14px;"><span style="display:inline-block;background-color:'
        .($isClosed ? '#9aa0a6' : '#7AC143')
        .';color:#ffffff;border-radius:20px;padding:7px 20px;font-weight:bold;font-size:14px;">'
        .Format::htmlchars($stName).'</span></p>'
        .'<p style="margin:0;font-size:13.5px;color:#5c6258;">'.Format::htmlchars($extra).'</p>';

    $subject = 'Status atualizado: '.$stName.' [#'.$ticket->getNumber().']';
    $body = zk_mail_zkteco($inner, (string) $ticket->getNumber(), zk_ticket_client_link($ticket));
    $email->send($owner, $subject, $body);
    return true;
}

/* Resposta consolidada na thread com as mudanças de equipamentos
   ($itens = lista de linhas HTML já prontas). postReply registra a
   "história" (visível no cartão Mensagens do cliente) e envia o e-mail
   pelo template ticket.reply. Fallback: nota interna. */
function zk_equip_notify_changes($ticket, array $itens) {
    if (!$itens)
        return false;
    $html = '<p><b>'.__('Atualização dos seus equipamentos').':</b></p><ul>';
    foreach ($itens as $li)
        $html .= '<li>'.$li.'</li>';
    $html .= '</ul><p style="color:#666;font-size:12px;">'
        .__('Você pode acompanhar todos os detalhes abrindo o chamado no portal.').'</p>';
    try {
        // 'reply-to' => 'all' é OBRIGATÓRIO: sem ele, Ticket::postReply chama
        // getRecipients(null) -> cai no default -> retorna null -> o guard de
        // envio ($email && $recipients && ...) falha e a resposta é gravada na
        // thread SEM enviar e-mail ao cliente. 'all' = dono + colaboradores.
        $vars = array('response' => $html, 'reply-to' => 'all');
        $err = array();
        if ($ticket->postReply($vars, $err, true, false))
            return true;
    } catch (Throwable $e) { /* cai no fallback */ }
    try {
        $ticket->logNote(__('Atualização de equipamentos'), $html, null, false);
    } catch (Throwable $e) { /* nunca bloqueia o salvamento */ }
    return false;
}

/* ------------------------------------------------------------------ *
 *  ATRIBUIÇÃO = CHEGADA: quando o produto chega na ZKTeco, o chamado é
 *  atribuído a um agente — nesse momento o status muda de "Enviado"
 *  para "Recebido" automaticamente. Só a transição Enviado→Recebido é
 *  feita (atribuir um chamado ainda "Solicitado" não mexe em nada: o
 *  produto nem foi despachado). A partir do Recebido, o acompanhamento
 *  fino é POR EQUIPAMENTO (status/laudo na tabela do chamado).
 *  Gancho: as rotas de atribuição a agente (assign/assignToStaff/claim)
 *  disparam Signal 'object.edited' com type='assigned'.
 * ------------------------------------------------------------------ */
function zk_ticket_on_assigned($ticket, $data = null) {
    if (!is_array($data) || !isset($data['type']) || $data['type'] !== 'assigned')
        return;
    if (!$ticket || !($ticket instanceof Ticket) || !$ticket->getId())
        return;
    if (!zk_equip_count((int) $ticket->getId()))
        return;
    $st = $ticket->getStatus();
    if (!$st || strcasecmp((string) $st->getName(), 'Enviado') !== 0)
        return;
    try {
        zk_ticket_set_status_by_name($ticket, 'Recebido');
    } catch (Throwable $e) { /* status é reflexo — nunca bloqueia a atribuição */ }
}
Signal::connect('object.edited', 'zk_ticket_on_assigned', 'Ticket');

/* Chamado TRAVADO pro cliente? Depois que o envio é CONFIRMADO o
   produto está em trânsito — o cliente não pode mais alterar nada do
   chamado (equipamentos, NF/XML, envio). A partir daí, validação e
   ajustes passam a ser do agente (tela a ser trabalhada no futuro). */
function zk_ticket_locked_for_client($ticket_id) {
    $e = zk_ticket_envio((int) $ticket_id);
    return (bool) $e['confirmado'];
}

/* Resumo textual do envio ("CORREIOS — Rastreio: XY123...") — usado no
   painel do agente (leitura) e nas notas de histórico. Com $comConfirmacao,
   acrescenta o estado da confirmação (confirmado em X / aguardando). */
function zk_ticket_envio_resumo($ticket_id, $comConfirmacao = false) {
    $e = zk_ticket_envio($ticket_id);
    if ($e['transportadora'] === '')
        return '';
    $s = zk_envio_transportadora_label($e['transportadora']);
    if ($e['transportadora'] === 'correios')
        $s .= ' — '.__('Rastreio').': '.$e['rastreio'];
    if ($comConfirmacao) {
        $s .= $e['confirmado']
            ? ' — '.__('envio confirmado em').' '.Format::datetime($e['confirmado'])
            : ' — '.__('aguardando confirmação do envio');
    }
    return $s;
}

/* ------------------------------------------------------------------ *
 *  Verificação do XML da NF contra as regras fixas da ZKTeco:
 *   - Destinatário (<dest>) precisa bater com os dados oficiais.
 *   - Não pode haver imposto destacado (é remessa p/ conserto, isenta).
 *   - CFOP só pode ser 5915 ou 6915 (remessa/retorno de conserto).
 *  Retorna array de mensagens de erro (vazio = XML válido).
 * ------------------------------------------------------------------ */
function zk_nfe_destinatario_esperado() {
    // Dados fixos do destinatário (ZKTeco do Brasil) — únicos aceitos.
    // O Complemento (enderDest.xCpl) NÃO é mais validado — ver
    // zk_nfe_complemento_endereco() abaixo.
    return array(
        'CNPJ'              => '08057340000160',
        'xNome'             => 'ZKTECO DO BRASIL S.A.',
        'enderDest.xLgr'    => 'Rua Maria Martins',
        'enderDest.nro'     => '11',
        'enderDest.xBairro' => 'Juliana',
        'enderDest.cMun'    => '3106200',
        'enderDest.xMun'    => 'Belo Horizonte',
        'enderDest.UF'      => 'MG',
        'enderDest.CEP'     => '31744590',
        'enderDest.cPais'   => '1058',
        'enderDest.xPais'   => 'Brasil',
        // enderDest.fone NÃO é validado — DDD com/sem zero à esquerda
        // ("031" vs "31") é só formatação, gerava falso positivo.
        // O telefone segue aparecendo na dica: zk_nfe_telefone().
        'indIEDest'         => '1',
        'IE'                => '0010128320010',
    );
}

/* Complemento do endereço do destinatário — fica FORA da validação do
   XML (campo de texto livre, cada fornecedor digita de um jeito e isso
   gerava falso positivo), mas o cliente PRECISA saber dele pra emitir a
   NF corretamente — por isso ele aparece na dica (zk_nf_dica_html). */
function zk_nfe_complemento_endereco() { return 'Galpao 01 Area 01'; }

/* Telefone do destinatário — também FORA da validação (formatação de DDD
   varia: "03130553530" vs "3130553530"), mas exibido na dica. */
function zk_nfe_telefone() { return '3130553530'; }

function zk_nfe_cfops_permitidos() { return array('5915', '6915'); }

// Normaliza texto pra comparação "tolerante": colapsa espaços múltiplos
// (comum em campos de texto livre como Complemento, digitados à mão de
// forma inconsistente entre notas), tira espaço das pontas, e ignora
// maiúsculas/minúsculas. Não afeta a validação de verdade (nome/endereço
// diferentes continuam pegando) — só evita falso positivo por espaçamento.
function zk_nfe_normalize_ws($s) {
    $s = preg_replace('/\s+/u', ' ', trim((string) $s));
    return mb_strtolower($s, 'UTF-8');
}

// Comparação dos campos do destinatário: além do espaçamento, ignora
// pontuação (. , / -) — "ZKTECO DO BRASIL S.A" vs "S.A." e CNPJ/CEP
// formatados são o MESMO dado, só escrito diferente; não é erro de NF.
// Conteúdo divergente de verdade (número, rua, cidade...) continua
// pegando, porque dígitos e letras não são tocados.
function zk_nfe_normalize_cmp($s) {
    return str_replace(array('.', ',', '/', '-'), '', zk_nfe_normalize_ws($s));
}

// Tags de valor de imposto do padrão NF-e — se algum vier > 0 em
// qualquer lugar do XML, é "imposto destacado" (não permitido aqui).
function zk_nfe_tags_imposto() {
    return array(
        'vICMS', 'vICMSST', 'vICMSDeson', 'vBCST', 'vFCP', 'vFCPST',
        'vIPI', 'vPIS', 'vCOFINS', 'vII', 'vIOF', 'vTotTrib',
    );
}

function zk_validate_nfe_xml($xmlContent) {
    $errors = array();

    $xmlContent = (string) $xmlContent;
    // Remove BOM (comum em exportações de sistemas de NF-e) e o
    // namespace default (xmlns="...") pra simplificar a navegação por
    // XPath sem precisar registrar prefixo de namespace.
    $xmlContent = preg_replace('/^\xEF\xBB\xBF/', '', $xmlContent);
    $clean = preg_replace('/xmlns(:\w+)?="[^"]*"/', '', $xmlContent);

    libxml_use_internal_errors(true);
    $xml = @simplexml_load_string($clean);
    libxml_clear_errors();
    if ($xml === false)
        return array(__('Arquivo XML inválido ou corrompido — não foi possível ler.'));

    // ---- Destinatário ----
    $destNodes = $xml->xpath('//dest');
    if (!$destNodes) {
        $errors[] = __('Bloco do destinatário (<dest>) não encontrado no XML.');
    } else {
        $dest = $destNodes[0];
        foreach (zk_nfe_destinatario_esperado() as $path => $expected) {
            $node = $dest;
            foreach (explode('.', $path) as $tag) {
                if ($node === null || !isset($node->$tag)) { $node = null; break; }
                $node = $node->$tag;
            }
            $actual = $node !== null ? trim((string) $node) : null;
            if ($actual === null || $actual === '') {
                $errors[] = sprintf(__('Destinatário: campo "%s" ausente no XML (esperado "%s").'), $path, $expected);
            // Compara ignorando espaçamento E pontuação (ver
            // zk_nfe_normalize_cmp) — espaço duplo, "S.A" vs "S.A.",
            // CNPJ/CEP com máscara etc. não são erros de destinatário
            // de verdade.
            } elseif (zk_nfe_normalize_cmp($actual) !== zk_nfe_normalize_cmp($expected)) {
                $errors[] = sprintf(__('Destinatário: "%s" está "%s", deveria ser "%s".'), $path, $actual, $expected);
            }
        }
    }

    // ---- CFOP ----
    $cfopNodes = $xml->xpath('//det/prod/CFOP');
    if (!$cfopNodes) {
        $errors[] = __('Nenhum CFOP encontrado no XML.');
    } else {
        $permitidos = zk_nfe_cfops_permitidos();
        foreach ($cfopNodes as $i => $cfopNode) {
            $cfop = trim((string) $cfopNode);
            if (!in_array($cfop, $permitidos, true)) {
                $errors[] = sprintf(__('CFOP do item %d é "%s" — só é permitido %s.'),
                    $i + 1, $cfop, implode(' ou ', $permitidos));
            }
        }
    }

    // ---- Impostos destacados ----
    foreach (zk_nfe_tags_imposto() as $tag) {
        foreach ($xml->xpath('//imposto//'.$tag) as $node) {
            $val = (float) str_replace(',', '.', (string) $node);
            if ($val > 0.0001) {
                $errors[] = sprintf(__('Imposto destacado encontrado (%s = %s) — esta NF não pode ter imposto destacado.'),
                    $tag, trim((string) $node));
            }
        }
    }

    return $errors;
}

/* Lê o XML já anexado ao chamado, valida contra as regras acima, e
   grava o resultado (lista de erros, ou string vazia se válido) na
   própria linha de ost_zk_ticket_file — depois sincroniza a Pendência
   de todos os equipamentos do chamado a partir desse resultado. */
function zk_verify_ticket_nf($ticket_id) {
    $tid = (int) $ticket_id;
    $files = zk_ticket_files($tid, 'nf');
    if (!$files)
        return false; // nada pra verificar

    $file = AttachmentFile::lookup((int) $files[0]['file_id']);
    if (!$file)
        return false;

    $errors = zk_validate_nfe_xml($file->getData());
    db_query('UPDATE '.zk_ticket_file_table().' SET errors='.db_input(implode("\n", $errors))
        .' WHERE id='.db_input((int) $files[0]['id']));

    zk_sync_equip_pendencia($tid);
    return true;
}

/* ------------------------------------------------------------------ *
 *  Título (subject) e descrição (message) AUTOMÁTICOS na criação.
 *  Como os campos genéricos do chamado foram removidos da tela, o
 *  osTicket ainda exige subject/message: geramos a partir da grade.
 *  'ticket.create.before' passa $vars (POST) POR REFERÊNCIA.
 * ------------------------------------------------------------------ */
function zk_equip_fill_ticket_vars($object, &$vars) {
    $rows = zk_equip_request_rows();
    if (!is_array($rows))
        return;
    $valid = array();
    foreach ($rows as $r) {
        if (!is_array($r)) continue;
        $m = isset($r['modelo']) ? trim((string) $r['modelo']) : '';
        $s = isset($r['serie'])  ? trim((string) $r['serie'])  : '';
        if ($m === '' && $s === '') continue;
        $valid[] = $r;
    }
    if (!$valid)
        return;
    $n = count($valid);

    // Assunto (fonte única — limite casa com o length do campo subject)
    if (empty($vars['subject']))
        $vars['subject'] = zk_equip_subject_text($valid);

    // Corpo/descrição do chamado (thread inicial)
    if (empty($vars['message'])) {
        $html  = '<p>Solicitação de manutenção com <b>'.$n.'</b> equipamento(s):</p><ol>';
        foreach ($valid as $r) {
            $m = Format::htmlchars(trim((string) $r['modelo']));
            $s = isset($r['serie']) ? Format::htmlchars(trim((string) $r['serie'])) : '';
            $html .= '<li><b>'.$m.'</b>'.($s !== '' ? ' — S/N '.$s : '');
            if (!empty($r['resumo']))       $html .= '<br><i>Resumo:</i> '.Format::htmlchars(trim((string) $r['resumo']));
            if (!empty($r['detalhamento'])) $html .= '<br><i>Detalhamento/Observação:</i> '.Format::htmlchars(trim((string) $r['detalhamento']));
            $html .= '</li>';
        }
        $html .= '</ol>';
        $vars['message'] = $html;
    }
}
Signal::connect('ticket.create.before', 'zk_equip_fill_ticket_vars');

/* A mensagem gerada acima só existe porque o osTicket exige subject/
   message na criação (e ela ainda alimenta o e-mail de confirmação via
   %{message}). No thread web ela é redundante com a grade de
   equipamentos, então Thread::render() a oculta quando esta função
   retorna true: chamado (não tarefa) que tenha equipamentos na grade.
   Posts que o cliente fizer depois não carregam FLAG_ORIGINAL_MESSAGE
   e continuam aparecendo normalmente. */
function zk_thread_hide_auto_original($thread) {
    if (!$thread || $thread->getObjectType() != ObjectModel::OBJECT_TYPE_TICKET)
        return false;
    return zk_equip_count((int) $thread->getObjectId()) > 0;
}

/* ------------------------------------------------------------------ *
 *  EDIÇÃO PELO CLIENTE (tela "Editar" do ticket) — zk-equip-edit.php
 *  Permite ao cliente corrigir dados de um equipamento já cadastrado,
 *  anexar fotos que esqueceu no cadastro original, ou adicionar um
 *  equipamento que faltou. Não altera status/laudo/nota interna
 *  (exclusivos do agente).
 *  Depois do "Confirmar envio", NADA mais é editável pelo cliente
 *  (zk_ticket_locked_for_client) — produto em trânsito.
 * ------------------------------------------------------------------ */
function zk_equip_client_can_edit($ticket) {
    global $thisclient;
    return $ticket && $thisclient
        && $ticket->checkUserAccess($thisclient)
        && $thisclient->getId() == $ticket->getUserId()
        && $ticket->hasClientEditableFields()
        && !zk_ticket_locked_for_client($ticket->getId());
}

/**
 * Processa o POST da tela de edição do cliente: atualiza equipamentos
 * existentes (por id) e cria os que forem novos, anexando fotos extras.
 * Retorna array(atualizados, criados, changes) — "changes" é uma lista
 * de descrições prontas ("Modelo: 'X' → 'Y'") por equipamento alterado,
 * usada pra montar uma nota-resumo detalhada (não só "N atualizado(s)"
 * — assim o histórico do chamado mostra exatamente o que mudou, sem
 * precisar cruzar com a tabela de equipamentos pra saber o estado atual).
 */
function zk_equip_client_process_edit($ticket) {
    $tid = (int) $ticket->getId();
    $rows = zk_equip_request_rows();
    if (!is_array($rows))
        return array(0, 0, array());

    $existing = array();
    $maxSeq = 0;
    foreach (zk_equip_list($tid) as $it) {
        $existing[(int) $it['id']] = $it;
        $maxSeq = max($maxSeq, (int) $it['seq']);
    }

    $fieldLabels = array(
        'modelo'       => __('Modelo'),
        'numero_serie' => __('Nº de Série'),
        'resumo'       => __('Falha Apresentada'),
        'detalhamento' => __('Observação'),
    );

    $updated = 0;
    $created = 0;
    $changes = array();
    foreach ($rows as $r) {
        if (!is_array($r)) continue;
        $modelo = isset($r['modelo']) ? trim((string) $r['modelo']) : '';
        $serie  = isset($r['serie'])  ? trim((string) $r['serie'])  : '';
        if ($modelo === '' && $serie === '')
            continue;
        $resumo   = isset($r['resumo'])       ? trim((string) $r['resumo'])       : '';
        $detal    = isset($r['detalhamento']) ? trim((string) $r['detalhamento']) : '';
        $photoKey = isset($r['photo_key'])    ? preg_replace('/[^A-Za-z0-9_-]/', '', (string) $r['photo_key']) : '';
        $id       = isset($r['id']) ? (int) $r['id'] : 0;

        if ($id && isset($existing[$id])) {
            $old = $existing[$id];
            $new = array('modelo' => $modelo, 'numero_serie' => $serie, 'resumo' => $resumo, 'detalhamento' => $detal);
            $itemChanges = array();
            foreach ($new as $field => $newVal) {
                $oldVal = isset($old[$field]) ? trim((string) $old[$field]) : '';
                if ($oldVal !== $newVal)
                    $itemChanges[] = sprintf('%s: "%s" → "%s"', $fieldLabels[$field], $oldVal, $newVal);
            }
            if ($itemChanges) {
                $label = $modelo !== '' ? $modelo : $old['modelo'];
                $changes[] = sprintf("%s (S/N %s):\n  - %s", $label, $serie !== '' ? $serie : $old['numero_serie'],
                    implode("\n  - ", $itemChanges));
            }

            db_query('UPDATE '.zk_equip_table().' SET '
                .'  modelo='.db_input(mb_substr($modelo, 0, 120))
                .', numero_serie='.db_input(mb_substr($serie, 0, 120))
                .', resumo='.db_input(mb_substr($resumo, 0, 255))
                .', detalhamento='.db_input(mb_substr($detal, 0, 200))
                .', updated=NOW()'
                .' WHERE id='.db_input($id).' AND ticket_id='.db_input($tid));
            $updated++;
            if ($photoKey !== '')
                zk_equip_save_uploaded_photos($tid, $id, $photoKey);
        } else {
            $maxSeq++;
            $sql = 'INSERT INTO '.zk_equip_table().' SET '
                 .'  ticket_id='.db_input($tid)
                 .', seq='.db_input($maxSeq)
                 .', modelo='.db_input(mb_substr($modelo, 0, 120))
                 .', numero_serie='.db_input(mb_substr($serie, 0, 120))
                 .', resumo='.db_input(mb_substr($resumo, 0, 255))
                 .', detalhamento='.db_input(mb_substr($detal, 0, 200))
                 .', status='.db_input(zk_equip_default_status())
                 .', created=NOW(), updated=NOW()';
            if (db_query($sql)) {
                $eid = db_insert_id();
                $created++;
                if ($eid && $photoKey !== '')
                    zk_equip_save_uploaded_photos($tid, $eid, $photoKey);
            }
        }
    }
    // Nota Fiscal do chamado: se o cliente anexou uma na tela de edição
    // (independente de ter mexido nos equipamentos), tenta salvar aqui
    // também — mesma função usada na abertura, mesma regra "só XML".
    zk_save_ticket_nf($tid);
    // Sincroniza a Pendência também aqui — cobre o caso de um equipamento
    // NOVO adicionado nesta edição (precisa nascer com a pendência certa
    // baseada na NF que já existia, mesmo se nenhuma NF nova foi anexada
    // agora).
    zk_sync_equip_pendencia($tid);
    // Mantém o Assunto do chamado em dia com os dados atuais dos
    // equipamentos (senão a listagem de "Chamados" e o título da tela
    // ficam com a informação antiga depois de uma edição).
    if ($updated || $created)
        zk_equip_refresh_subject($ticket);
    return array($updated, $created, $changes);
}

/**
 * Regera o Assunto do chamado a partir dos equipamentos atuais, com a
 * MESMA regra usada na abertura (fonte única: zk_equip_subject_text —
 * 1 item mostra modelo+S/N; vários agrupam por modelo com contagem).
 * Chamada depois de qualquer edição de equipamento
 * pelo cliente, pra o título do chamado (cabeçalho e listagem de
 * "Chamados") não ficar desatualizado em relação ao item que gerou ele.
 *
 * Grava direto na DynamicFormEntryAnswer (em vez de $entry->save(), que
 * passaria por getClean()/to_database() de TODOS os campos da entry —
 * pensado pra fluxo vindo de $_POST, não pra uma atualização pontual
 * como esta). VerySimpleModel::save() já dispara o Signal que sincroniza
 * a ost_ticket__cdata sozinho, então não precisa de mais nada.
 */
function zk_equip_refresh_subject($ticket) {
    $tid = (int) $ticket->getId();
    $items = zk_equip_list($tid);
    if (!$items)
        return false;

    $subj = zk_equip_subject_text($items);
    if ($subj === '')
        return false;

    foreach (DynamicFormEntry::forTicket($tid) as $entry) {
        $ans = $entry->getAnswer('subject');
        if (!$ans)
            continue;
        $field = $ans->getField();
        if (!$field->isStorable())
            continue;
        if ((string) $ans->getValue() === $subj)
            return true; // já está atualizado, nada a fazer
        $ans->setValue($subj);
        $ans->save();
        // Se o objeto $ticket já tinha o assunto antigo em cache
        // (getSubject() chamado antes desta função no mesmo request),
        // força recarregar pra refletir o novo valor imediatamente.
        if (method_exists($ticket, 'loadDynamicData'))
            $ticket->loadDynamicData(true);
        return true;
    }
    return false;
}

/* ------------------------------------------------------------------ *
 *  Housekeeping: limpar itens quando o ticket é deletado
 * ------------------------------------------------------------------ */
function zk_equip_on_ticket_deleted($ticket, $data = null) {
    if (!$ticket || !method_exists($ticket, 'getId') || !$ticket->getId())
        return;
    $tid = (int) $ticket->getId();
    // Arquivos do módulo (fotos/NF/DC): com o ft='Z' (blindado do cron do
    // core) eles nunca mais seriam limpos — coleta os ids ANTES de apagar
    // os vínculos e remove os que ficarem sem nenhuma referência.
    $__fids = array();
    foreach (array(zk_equip_file_table(), zk_ticket_file_table()) as $__t) {
        $r = db_query('SELECT DISTINCT file_id FROM '.$__t.' WHERE ticket_id='.db_input($tid));
        if ($r) while ($row = db_fetch_array($r)) $__fids[(int) $row['file_id']] = true;
    }
    db_query('DELETE FROM '.zk_equip_table().' WHERE ticket_id='.db_input($tid));
    db_query('DELETE FROM '.zk_equip_event_table().' WHERE ticket_id='.db_input($tid));
    db_query('DELETE FROM '.zk_equip_file_table().' WHERE ticket_id='.db_input($tid));
    db_query('DELETE FROM '.zk_ticket_file_table().' WHERE ticket_id='.db_input($tid));
    foreach (array_keys($__fids) as $__fid)
        zk_file_delete_if_unused($__fid);
    // Envio do produto (transportadora/rastreio) — faltava aqui; achado ao
    // apagar um lote de tickets de teste (2026-07-03): sobraram linhas
    // órfãs em zk_ticket_envio pros tickets removidos.
    db_query('DELETE FROM '.zk_ticket_envio_table().' WHERE ticket_id='.db_input($tid));
}
// 'model.deleted' dispara para qualquer modelo; filtramos por classe Ticket.
Signal::connect('model.deleted', 'zk_equip_on_ticket_deleted', 'Ticket');

/* ------------------------------------------------------------------ *
 *  Consultas
 * ------------------------------------------------------------------ */
function zk_equip_list($ticket_id) {
    $tid  = (int) $ticket_id;
    $rows = array();
    $res  = db_query('SELECT * FROM '.zk_equip_table()
                    .' WHERE ticket_id='.db_input($tid).' ORDER BY seq, id');
    if ($res)
        while ($r = db_fetch_array($res))
            $rows[] = $r;
    return $rows;
}
function zk_equip_count($ticket_id) {
    $tid = (int) $ticket_id;
    $res = db_query('SELECT COUNT(*) FROM '.zk_equip_table().' WHERE ticket_id='.db_input($tid));
    return ($res && ($n = db_result($res))) ? (int) $n : 0;
}

/**
 * Busca "inteligente": retorna os ids de ticket cujos equipamentos batem
 * com $q em qualquer campo relevante (modelo, nº de série, resumo,
 * detalhamento, observação do cliente, laudo). Usado por tickets.inc.php
 * para que a busca da lista de chamados enxergue também os dados dos
 * equipamentos — que ficam numa tabela própria, fora do índice de busca
 * nativo do osTicket (que só cobre assunto/mensagens da thread).
 * 'nota_interna' (uso exclusivo do agente) é propositalmente excluída.
 */
function zk_equip_matching_ticket_ids($q) {
    $q = trim((string) $q);
    if ($q === '')
        return array();
    $like = "'%".db_real_escape($q, false)."%'";
    $ids = array();
    $res = db_query('SELECT DISTINCT ticket_id FROM '.zk_equip_table()
        .' WHERE modelo LIKE '.$like
        .' OR numero_serie LIKE '.$like
        .' OR resumo LIKE '.$like
        .' OR detalhamento LIKE '.$like
        .' OR laudo LIKE '.$like);
    if ($res)
        while ($r = db_fetch_array($res))
            $ids[] = (int) $r['ticket_id'];
    return $ids;
}
function zk_equip_stats($ticket_id) {
    $tid = (int) $ticket_id;
    $st  = zk_equip_statuses();
    $counts = array(); $total = 0; $done = 0;
    $res = db_query('SELECT status, COUNT(*) AS c FROM '.zk_equip_table()
                   .' WHERE ticket_id='.db_input($tid).' GROUP BY status');
    if ($res) {
        while ($r = db_fetch_array($res)) {
            $c = (int) $r['c'];
            $counts[$r['status']] = $c;
            $total += $c;
            if (isset($st[$r['status']]) && $st[$r['status']]['done'])
                $done += $c;
        }
    }
    return array('counts' => $counts, 'total' => $total, 'done' => $done,
                 'pct' => zk_equip_progress_from_counts($counts, $total));
}
function zk_equip_events($equipment_id) {
    $eid  = (int) $equipment_id;
    $rows = array();
    $res  = db_query('SELECT * FROM '.zk_equip_event_table()
                    .' WHERE equipment_id='.db_input($eid).' ORDER BY id');
    if ($res)
        while ($r = db_fetch_array($res))
            $rows[] = $r;
    return $rows;
}

function zk_equip_files($ticket_id) {
    $tid = (int) $ticket_id;
    $out = array();
    $res = db_query('SELECT ef.*, f.name, f.type, f.size'
        .' FROM '.zk_equip_file_table().' ef'
        .' INNER JOIN '.FILE_TABLE.' f ON (f.id = ef.file_id)'
        .' WHERE ef.ticket_id='.db_input($tid)
        .' ORDER BY ef.equipment_id, ef.slot, ef.id');
    if ($res) {
        while ($r = db_fetch_array($res)) {
            $eid = (int) $r['equipment_id'];
            if (!isset($out[$eid]))
                $out[$eid] = array();
            $out[$eid][] = $r;
        }
    }
    return $out;
}

function zk_equip_photo_links_html($files) {
    if (!$files)
        return '';
    $h = '<div class="zk-photos">';
    foreach ($files as $f) {
        $file = AttachmentFile::lookup((int) $f['file_id']);
        if (!$file)
            continue;
        $url = Format::htmlchars($file->getDownloadUrl(array('disposition' => 'inline')));
        $h .= '<a class="zk-photo-thumb no-pjax" target="_blank" href="'.$url
            . '" title="'.Format::htmlchars($f['name']).'">'
            . '<img src="'.$url.'" alt="'.Format::htmlchars($f['name']).'" loading="lazy"></a>';
    }
    $h .= '</div>';
    return $h;
}

/* Barra de progresso + chips (HTML), compartilhada pelos 2 painéis */
function zk_equip_progress_html($stats) {
    $st  = zk_equip_statuses();
    // Progresso PONDERADO (média das etapas); a contagem de concluídos
    // vira informação de apoio.
    $pct = isset($stats['pct']) ? (int) $stats['pct']
         : zk_equip_progress_from_counts($stats['counts'], $stats['total']);
    $h  = '<div class="zk-progress-wrap">';
    $h .= '<div class="zk-progress-top"><b class="zk-progress-big">'.$pct.'%</b> '
        . __('concluído')
        . ' <span class="zk-progress-pct">&middot; '.(int)$stats['done'].' '
        . __('de').' '.(int)$stats['total'].' '
        . ((int)$stats['total'] == 1 ? __('equipamento finalizado') : __('equipamentos finalizados'))
        . '</span></div>';
    $h .= '<div class="zk-progress-bar"><span style="width:'.$pct.'%"></span></div>';
    $h .= '<div class="zk-chips">';
    foreach ($st as $key => $meta) {
        if (empty($stats['counts'][$key])) continue;
        $h .= '<span class="zk-chip" style="border-color:'.$meta['color'].'">'
            . '<i class="zk-dot" style="background:'.$meta['color'].'"></i>'
            . Format::htmlchars($meta['label']).' <b>'.(int)$stats['counts'][$key].'</b></span>';
    }
    $h .= '</div></div>';
    return $h;
}

/* ------------------------------------------------------------------ *
 *  PAINEL DO CLIENTE (somente leitura) — chamado de client/view.inc.php
 * ------------------------------------------------------------------ */
function zk_equipment_client_panel($ticket) {
    if (!$ticket || !method_exists($ticket, 'getId')) return;
    $tid   = $ticket->getId();
    $items = zk_equip_list($tid);
    if (!$items) return;
    $stats = zk_equip_stats($tid);
    $files = zk_equip_files($tid);
    zk_equip_styles();
    ?>
<div class="zk-panel zk-client">
  <div class="zk-panel-head">
    <?php /* ícone só no painel do cliente — no tema do cliente o painel
             vira "cartão" (ver .zk-panel.zk-client no theme.css) */ ?>
    <h3 class="zk-panel-title"><i class="icon-wrench"></i> <?php echo sprintf(__('Equipamentos (%d)'), count($items)); ?></h3>
  </div>
  <?php /* Nota Fiscal em barra própria (irmã da barra de Envio), fora do
           cabeçalho do cartão — no cabeçalho ficava solta/feia. Estilo
           .zk-nf-bar no theme.css (cliente). No agente segue no head. */ ?>
  <?php
  /* ------------------------------------------------------------------
     GUIA DE PRÓXIMOS PASSOS — teste com usuário real (2026-07-03)
     mostrou que o clipe pequeno da NF e o select discreto do envio
     passavam despercebidos. O guia destaca O PRÓXIMO passo com botão
     grande: 1 anexar NF -> 2 informar/confirmar envio -> 3 acompanhar.
     As barras de NF/Envio abaixo viram INFORMAÇÃO; as ações principais
     moram aqui (mesmos forms/ids de antes — o JS no fim não muda).
     ------------------------------------------------------------------ */
  $podeEditar = zk_equip_client_can_edit($ticket);
  $__nfPend   = zk_ticket_nf_pendencia($tid); // '' = verificada e sem erro
  $__temNF    = (bool) zk_ticket_files($tid, 'nf');
  $__nfOk     = $__temNF && $__nfPend === '';
  $__temDC    = (bool) zk_ticket_files($tid, 'dc');
  $__dcMode   = $__temDC && !$__temNF;   // cliente final: Declaração de Conteúdo
  $__docsOk   = $__nfOk || $__dcMode;    // documentação do envio resolvida
  $envio      = zk_ticket_envio($tid);
  $transps    = zk_envio_transportadoras();

  if ($envio['confirmado']) {
      // Depois que o agente assume o chamado (chegada), o status vira
      // "Recebido" — o banner acompanha a etapa real do produto.
      $__stName = ($__s = $ticket->getStatus()) ? (string) $__s->getName() : '';
      $__chegou = (strcasecmp($__stName, 'Recebido') === 0);
  ?>
  <div class="zk-guide zk-guide-done">
    <i class="icon-ok-sign zk-guide-done-ico"></i>
    <div class="zk-guide-body">
      <b><?php echo $__chegou
          ? __('Produto recebido na ZKTeco — atendimento em andamento.')
          : __('Tudo certo por aqui — produto a caminho da ZKTeco.'); ?></b>
      <span><?php echo $__chegou
          ? __('Nossa equipe técnica está com o(s) seu(s) equipamento(s). Acompanhe o status de cada um na tabela abaixo — você recebe um e-mail a cada atualização.')
          : __('Agora é com a gente: acompanhe o status de cada equipamento na tabela abaixo. Você recebe um e-mail a cada atualização.'); ?></span>
    </div>
  </div>
  <?php } elseif ($podeEditar && !$__docsOk) { ?>
  <div class="zk-guide<?php if ($__nfPend === 'nf_com_erro') echo ' zk-guide-warn'; ?>">
    <span class="zk-guide-step">1</span>
    <div class="zk-guide-body">
      <?php if (!$__temNF) { ?>
      <b><?php echo __('Próximo passo: anexar a Nota Fiscal de remessa (XML)'); ?></b>
      <span><?php echo __('Para o produto viajar até a ZKTeco é obrigatória a NF-e de remessa para conserto. Anexe o arquivo XML — a verificação é automática, na hora.'); ?></span>
      <div class="zk-guide-actions">
        <form method="post" action="<?php echo ROOT_PATH; ?>zk-equip-edit.php" enctype="multipart/form-data" class="zk-nf-quick-upload-form" id="zkNfQuickUploadForm">
          <?php csrf_token(); ?>
          <input type="hidden" name="id" value="<?php echo (int) $tid; ?>">
          <label class="zk-guide-attach">
            <?php /* class="nowarn" no input: o change já envia o form,
                     não existe alteração a "perder" (aviso do core) */ ?>
            <i class="icon-paperclip"></i> <?php echo __('Anexar Nota Fiscal (XML)'); ?>
            <input type="file" name="zk_ticket_nf" class="nowarn" accept=".xml,text/xml,application/xml" id="zkNfQuickUploadInput">
          </label>
        </form>
        <?php echo zk_nf_dica_html(); ?>
        <span class="zk-guide-hint"><?php echo __('dúvida sobre como emitir? clique no (?)'); ?></span>
      </div>
      <?php /* Caminho do CLIENTE FINAL: pessoa física não emite NF-e —
               os Correios aceitam a Declaração de Conteúdo no lugar, e
               então o envio é obrigatoriamente pelos CORREIOS. */ ?>
      <div class="zk-guide-alt">
        <a href="#" id="zkDcToggle" class="zk-guide-alt-link"><i class="icon-user"></i>
          <?php echo __('Sou cliente final e não emito Nota Fiscal'); ?></a>
        <div class="zk-guide-alt-body" id="zkDcBody" style="display:none">
          <p style="margin:0 0 10px;"><?php echo __('Sem Nota Fiscal, o envio é feito obrigatoriamente pelos CORREIOS acompanhado da Declaração de Conteúdo — o formulário dos Correios que vai no pacote no lugar da NF. Preencha e assine a declaração, e anexe aqui uma cópia (PDF ou foto).'); ?></p>
          <form method="post" action="<?php echo ROOT_PATH; ?>zk-equip-edit.php" enctype="multipart/form-data" id="zkDcUploadForm">
            <?php csrf_token(); ?>
            <input type="hidden" name="id" value="<?php echo (int) $tid; ?>">
            <label class="zk-guide-attach zk-guide-attach-alt">
              <i class="icon-file"></i> <?php echo __('Anexar Declaração de Conteúdo'); ?>
              <input type="file" name="zk_ticket_dc" class="nowarn"
                     accept=".pdf,.jpg,.jpeg,.png,application/pdf,image/*" id="zkDcUploadInput">
            </label>
          </form>
        </div>
      </div>
      <?php } elseif ($__nfPend === 'nf_com_erro') { ?>
      <b><?php echo __('A Nota Fiscal anexada tem erros — anexe o XML corrigido'); ?></b>
      <span><?php echo __('Confira a tabela de erros logo abaixo (o que está na NF × o que deveria estar), corrija a emissão e anexe o novo XML — ele substitui o anterior automaticamente.'); ?></span>
      <div class="zk-guide-actions">
        <form method="post" action="<?php echo ROOT_PATH; ?>zk-equip-edit.php" enctype="multipart/form-data" class="zk-nf-quick-upload-form" id="zkNfQuickUploadForm">
          <?php csrf_token(); ?>
          <input type="hidden" name="id" value="<?php echo (int) $tid; ?>">
          <label class="zk-guide-attach">
            <i class="icon-paperclip"></i> <?php echo __('Anexar XML corrigido'); ?>
            <input type="file" name="zk_ticket_nf" class="nowarn" accept=".xml,text/xml,application/xml" id="zkNfQuickUploadInput">
          </label>
        </form>
      </div>
      <?php } else { /* NF anexada antes da verificação automática existir */ ?>
      <b><?php echo __('Próximo passo: verificar o XML da Nota Fiscal'); ?></b>
      <span><?php echo __('A NF anexada ainda não foi conferida — clique para validar destinatário, CFOP e impostos.'); ?></span>
      <div class="zk-guide-actions">
        <form method="post" action="<?php echo ROOT_PATH; ?>zk-equip-edit.php">
          <?php csrf_token(); ?>
          <input type="hidden" name="id" value="<?php echo (int) $tid; ?>">
          <input type="hidden" name="zk_ticket_nf_verify" value="1">
          <button type="submit" class="zk-guide-attach zk-guide-btn">
            <i class="icon-refresh"></i> <?php echo __('Verificar XML agora'); ?>
          </button>
        </form>
      </div>
      <?php } ?>
      <span class="zk-guide-trail"><?php echo __('Passo 1 de 3'); ?> &middot; <?php
        echo __('depois:'); ?> <b><?php echo __('informar o envio'); ?></b> &rarr; <?php
        echo __('acompanhar o reparo'); ?></span>
    </div>
  </div>
  <?php } elseif ($podeEditar) { /* documentação ok — passo 2: envio do produto */
      // Cliente final (Declaração de Conteúdo): só CORREIOS, já selecionado.
      $__transpOpts = $__dcMode ? array('correios' => $transps['correios']) : $transps;
      $__selTransp  = $envio['transportadora'] !== ''
          ? $envio['transportadora'] : ($__dcMode ? 'correios' : '');
  ?>
  <div class="zk-guide">
    <span class="zk-guide-step">2</span>
    <div class="zk-guide-body">
      <b><?php echo $envio['transportadora'] === ''
          ? __('Próximo passo: informe como o produto será enviado')
          : __('Falta só confirmar o envio do produto'); ?></b>
      <span><?php
        if ($envio['transportadora'] !== '')
            echo __('Se o produto já foi despachado, clique em "Confirmar envio". Depois da confirmação os dados travam e o reparo segue com a gente.');
        elseif ($__dcMode)
            echo __('Cliente final com Declaração de Conteúdo: o envio é obrigatoriamente pelos CORREIOS — leve o pacote com a declaração dentro, informe aqui o código de rastreio e salve. Depois de despachar, confirme o envio.');
        else
            echo __('Escolha a transportadora e salve — para CORREIOS, informe também o código de rastreio. Depois de despachar o produto, volte aqui e confirme o envio.');
      ?></span>
      <div class="zk-guide-actions">
        <form method="post" action="<?php echo ROOT_PATH; ?>zk-equip-edit.php" class="zk-envio-form" id="zkEnvioForm">
          <?php csrf_token(); ?>
          <input type="hidden" name="id" value="<?php echo (int) $tid; ?>">
          <input type="hidden" name="zk_envio_save" value="1">
          <?php /* class="nowarn" nos 2 campos: ação imediata (escolheu/
                   salvou); sem isso, mexer no select já armava o aviso
                   "Sair do site?" do core em qualquer navegação. */ ?>
          <select name="zk_transportadora" id="zkEnvioTransp" class="nowarn">
            <?php if (!$__dcMode) { ?>
            <option value=""><?php echo __('— selecione a transportadora —'); ?></option>
            <?php }
            foreach ($__transpOpts as $k => $lbl)
                echo '<option value="'.$k.'"'.($k === $__selTransp ? ' selected' : '').'>'.Format::htmlchars($lbl).'</option>'; ?>
          </select>
          <input type="text" name="zk_rastreio" id="zkEnvioRastreio" class="nowarn" maxlength="64"
                 placeholder="<?php echo __('Código de rastreio'); ?>"
                 value="<?php echo Format::htmlchars($envio['rastreio']); ?>"
                 <?php if ($__selTransp !== 'correios') echo 'style="display:none"'; ?>>
          <button type="submit" class="zk-envio-save"><?php echo __('Salvar'); ?></button>
          <?php /* "Confirmar envio" só depois do tipo de envio salvo (o
                   servidor processa zk_envio_confirm antes de zk_envio_save) */
          if ($envio['transportadora'] !== '') { ?>
          <button type="submit" name="zk_envio_confirm" value="1" class="zk-envio-confirm"
                  title="<?php echo __('Confirme quando o produto tiver sido despachado'); ?>">
            <i class="icon-ok"></i> <?php echo __('Confirmar envio'); ?>
          </button>
          <?php } ?>
        </form>
      </div>
      <span class="zk-guide-trail"><?php echo __('Passo 2 de 3'); ?> &middot; <?php
        echo $__dcMode ? __('Declaração de Conteúdo') : __('Nota Fiscal'); ?> <i class="icon-ok"></i> &middot; <?php
        echo __('depois:'); ?> <b><?php echo __('acompanhar o reparo'); ?></b></span>
    </div>
  </div>
  <?php } ?>
  <?php /* Barra da NF vira só INFORMAÇÃO (arquivo + selo + lixeira/dica);
           só aparece quando existe NF anexada — sem NF, quem age é o guia. */
  if ($__temNF) { ?>
  <div class="zk-nf-bar zk-ticket-nf-status">
      <?php echo zk_ticket_nf_html($tid); ?>
      <?php if ($__nfOk) { ?>
      <span class="zk-nf-valid" title="<?php echo __('XML verificado automaticamente — destinatário, CFOP e impostos OK'); ?>">
        <i class="icon-ok-sign"></i> <?php echo __('XML validado'); ?>
      </span>
      <?php }
      if ($podeEditar) {
          if ($__nfPend === 'nf_com_erro') { ?>
      <form method="post" action="<?php echo ROOT_PATH; ?>zk-equip-edit.php" class="zk-nf-verify-form">
        <?php csrf_token(); ?>
        <input type="hidden" name="id" value="<?php echo (int) $tid; ?>">
        <input type="hidden" name="zk_ticket_nf_verify" value="1">
        <button type="submit" class="zk-nf-verify-btn" title="<?php echo __('Verificar XML da Nota Fiscal'); ?>">
          <i class="icon-refresh"></i> <?php echo __('Verificar XML'); ?>
        </button>
      </form>
      <?php } ?>
      <?php /* Lixeira: apaga a NF direto do painel (mesma rota da tela de
               editar; zk_back_ticket devolve pra cá). */ ?>
      <form method="post" action="<?php echo ROOT_PATH; ?>zk-equip-edit.php" class="zk-nf-verify-form"
            onsubmit="return confirm('<?php echo __('Remover a Nota Fiscal anexada a este chamado? Depois é só anexar a correta.'); ?>');">
        <?php csrf_token(); ?>
        <input type="hidden" name="id" value="<?php echo (int) $tid; ?>">
        <input type="hidden" name="zk_ticket_nf_delete" value="1">
        <input type="hidden" name="zk_back_ticket" value="1">
        <button type="submit" class="zk-nf-del-btn" title="<?php echo __('Remover Nota Fiscal (para anexar outra)'); ?>">
          <i class="icon-trash"></i>
        </button>
      </form>
      <?php echo zk_nf_dica_html();
      } ?>
  </div>
  <?php } ?>
  <?php /* Barra da Declaração de Conteúdo (cliente final) — informação +
           lixeira pra trocar o arquivo enquanto o chamado for editável. */
  if ($__temDC) { ?>
  <div class="zk-nf-bar">
      <?php echo zk_ticket_dc_html($tid); ?>
      <span class="zk-dc-badge" title="<?php echo __('Cliente final — sem NF, envio somente pelos CORREIOS'); ?>">
        <i class="icon-user"></i> <?php echo __('Cliente final'); ?>
      </span>
      <?php if ($podeEditar) { ?>
      <form method="post" action="<?php echo ROOT_PATH; ?>zk-equip-edit.php" class="zk-nf-verify-form"
            onsubmit="return confirm('<?php echo __('Remover a Declaração de Conteúdo deste chamado?'); ?>');">
        <?php csrf_token(); ?>
        <input type="hidden" name="id" value="<?php echo (int) $tid; ?>">
        <input type="hidden" name="zk_ticket_dc_delete" value="1">
        <button type="submit" class="zk-nf-del-btn" title="<?php echo __('Remover Declaração de Conteúdo (para anexar outra)'); ?>">
          <i class="icon-trash"></i>
        </button>
      </form>
      <?php } ?>
  </div>
  <?php } ?>
  <?php $__zk_nf_errors = zk_ticket_nf_errors_html($tid); if ($__zk_nf_errors) { ?>
  <div class="zk-nf-errors-box">
    <b><?php echo __('Erros encontrados na Nota Fiscal:'); ?></b>
    <?php echo $__zk_nf_errors; ?>
  </div>
  <?php } ?>
  <?php
  // Envio do produto — barra agora é só INFORMAÇÃO (o formulário de
  // salvar/confirmar mora no GUIA acima, quando NF ok e chamado editável).
  // Confirmado: resumo + data. Informado mas sem guia editável (chamado
  // travado ou NF trocada com erro): resumo somente-leitura.
  if ($envio['confirmado']) { ?>
  <div class="zk-envio-bar">
    <span class="zk-envio-label"><i class="icon-truck"></i> <?php echo __('Envio do produto:'); ?></span>
    <b><?php echo Format::htmlchars(zk_ticket_envio_resumo($tid)); ?></b>
    <span class="zk-envio-ok"><i class="icon-ok"></i>
      <?php echo __('Envio confirmado em').' '.Format::datetime($envio['confirmado']); ?></span>
  </div>
  <?php } elseif ($envio['transportadora'] !== '' && (!$podeEditar || !$__docsOk)) {
      $__zk_envio_resumo = zk_ticket_envio_resumo($tid, true); ?>
  <div class="zk-envio-bar">
    <span class="zk-envio-label"><i class="icon-truck"></i> <?php echo __('Envio do produto:'); ?></span>
    <?php echo $__zk_envio_resumo !== ''
        ? '<b>'.Format::htmlchars($__zk_envio_resumo).'</b>'
        : '<span class="zk-muted">'.__('não informado').'</span>'; ?>
  </div>
  <?php } ?>
  <script type="text/javascript">
  (function($){
    $(function(){
      // Anexar NF direto do painel do chamado (sem precisar ir pra tela de
      // editar equipamentos) — escolheu o arquivo, já envia. Mesma
      // validação de ".xml" que as outras telas (extensão + servidor).
      $('#zkNfQuickUploadInput').on('change', function(){
        var file = this.files && this.files[0];
        if (file && !/\.xml$/i.test(file.name)) {
          alert('<?php echo __('A Nota Fiscal precisa ser um arquivo .xml.'); ?>');
          $(this).val('');
          return;
        }
        // Submit via jQuery (não o .submit() nativo): passa pelo handler
        // global do core (osticket.js) que desliga o aviso "Sair do site?".
        if (file) $('#zkNfQuickUploadForm').trigger('submit');
      });
      // Envio do produto: rastreio só aparece (e só é exigido) pros CORREIOS.
      $('#zkEnvioTransp').on('change', function(){
        $('#zkEnvioRastreio').toggle($(this).val() === 'correios');
      });
      $('#zkEnvioForm').on('submit', function(e){
        var t = $('#zkEnvioTransp').val();
        if (!t) {
          alert('<?php echo __('Selecione a transportadora.'); ?>');
          return false;
        }
        if (t === 'correios' && !$.trim($('#zkEnvioRastreio').val())) {
          alert('<?php echo __('Informe o código de rastreio dos CORREIOS.'); ?>');
          $('#zkEnvioRastreio').focus();
          return false;
        }
        // Se o submit veio do botão "Confirmar envio", pede confirmação —
        // depois de confirmado os dados travam.
        var sub = e.originalEvent && e.originalEvent.submitter;
        if (sub && sub.name === 'zk_envio_confirm'
            && !confirm('<?php echo __('Confirmar que o produto já foi enviado? Depois de confirmado, os dados do envio não poderão mais ser alterados.'); ?>'))
          return false;
      });
      // Cliente final: revela o caminho da Declaração de Conteúdo e envia
      // o arquivo assim que escolhido (mesmo padrão do upload da NF).
      $('#zkDcToggle').on('click', function(e){
        e.preventDefault();
        $('#zkDcBody').slideToggle(120);
      });
      $('#zkDcUploadInput').on('change', function(){
        var file = this.files && this.files[0];
        if (file && !/\.(pdf|jpe?g|png)$/i.test(file.name)) {
          alert('<?php echo __('A Declaração de Conteúdo precisa ser PDF, JPG ou PNG.'); ?>');
          $(this).val('');
          return;
        }
        if (file) $('#zkDcUploadForm').trigger('submit');
      });
    });
  })(jQuery);
  </script>
  <?php echo zk_equip_progress_html($stats); ?>
  <div class="zk-toolbar">
    <input type="text" class="zk-search" placeholder="<?php echo __('Buscar por modelo ou nº de série...'); ?>">
  </div>
  <div class="zk-table-wrap">
  <table class="zk-table">
    <thead><tr>
      <th class="zk-c-num">#</th>
      <th><?php echo __('Equipamento'); ?></th>
      <th><?php echo __('Problema relatado'); ?></th>
      <th><?php echo __('Status'); ?></th>
      <th><?php echo __('Pendência'); ?></th>
      <th><?php echo __('Laudo técnico'); ?></th>
      <th class="zk-nowrap"><?php echo __('Atualizado'); ?></th>
    </tr></thead>
    <tbody>
    <?php foreach ($items as $it) {
        $color = zk_equip_status_color($it['status']);
        $label = zk_equip_status_label($it['status']);
        $itFiles = isset($files[(int)$it['id']]) ? $files[(int)$it['id']] : array();
        $pendKey = isset($it['pendencia']) ? $it['pendencia'] : ''; ?>
      <tr class="zk-row">
        <td class="zk-c-num"><?php echo (int) $it['seq']; ?></td>
        <td>
          <b><?php echo Format::htmlchars($it['modelo']); ?></b>
          <?php if ($it['numero_serie'] !== '') echo '<div class="zk-sub zk-muted">S/N: '.Format::htmlchars($it['numero_serie']).'</div>'; ?>
        </td>
        <td>
          <div class="zk-issue-row">
            <div class="zk-issue-text">
              <?php if (!empty($it['resumo'])) echo '<b class="zk-issue-line" title="'.Format::htmlchars($it['resumo']).'">'.Format::htmlchars($it['resumo']).'</b>'; ?>
              <?php if (!empty($it['detalhamento'])) echo '<span class="zk-issue-line zk-sub" title="'.Format::htmlchars($it['detalhamento']).'">'.Format::htmlchars($it['detalhamento']).'</span>'; ?>
            </div>
            <?php echo zk_equip_photo_links_html($itFiles); ?>
          </div>
        </td>
        <td><span class="zk-badge" style="--badge-c:<?php echo $color; ?>"><?php echo Format::htmlchars($label); ?></span></td>
        <td><?php echo $pendKey !== ''
            ? '<span class="zk-badge zk-badge-pend" style="--badge-c:'.zk_equip_pendencia_color($pendKey).'">'.Format::htmlchars(zk_equip_pendencia_label($pendKey)).'</span>'
            : '<span class="zk-muted">—</span>'; ?></td>
        <td><?php echo ($it['laudo'] !== null && $it['laudo'] !== '') ? nl2br(Format::htmlchars($it['laudo'])) : '<span class="zk-muted">—</span>'; ?></td>
        <td class="zk-nowrap zk-muted"><?php echo Format::datetime($it['updated']); ?></td>
      </tr>
    <?php } ?>
    </tbody>
  </table>
  </div>
</div>
<script type="text/javascript">
(function($){
  $(function(){
    var $p = $('.zk-panel.zk-client');
    $p.find('.zk-search').on('keyup', function(){
      var q = $(this).val().toLowerCase();
      $p.find('tbody tr.zk-row').each(function(){
        $(this).toggle($(this).text().toLowerCase().indexOf(q) > -1);
      });
    });
  });
})(jQuery);
</script>
    <?php
}

/* ------------------------------------------------------------------ *
 *  PAINEL DO AGENTE (editável) — chamado de staff/ticket-view.inc.php
 *  Form simples (POST) para scp/zk-equip.php. Sem AJAX (robusto).
 * ------------------------------------------------------------------ */
function zk_equipment_staff_panel($ticket) {
    global $thisstaff;
    if (!$ticket || !method_exists($ticket, 'getId')) return;
    $tid   = $ticket->getId();
    $items = zk_equip_list($tid);
    if (!$items) return;
    $st    = zk_equip_statuses();
    $stats = zk_equip_stats($tid);
    $files = zk_equip_files($tid);
    zk_equip_styles();
    ?>
<div class="zk-panel zk-staff" id="zk-staff-panel">
  <div class="zk-panel-head">
    <h3 class="zk-panel-title"><i class="icon-wrench"></i> <?php echo sprintf(__('Equipamentos (%d)'), count($items)); ?></h3>
  </div>
  <?php /* Nota Fiscal em barra própria (mesma cara do painel do cliente):
           arquivo + selo "XML validado" + ações do agente (verificar/anexar).
           Antes ficava espremida no cabeçalho — agora é barra irmã da de Envio. */
  $__nfOk = zk_ticket_files($tid, 'nf') && zk_ticket_nf_pendencia($tid) === ''; ?>
  <div class="zk-nf-bar zk-ticket-nf-status">
      <?php echo zk_ticket_nf_html($tid); ?>
      <?php if ($__nfOk) { ?>
      <span class="zk-nf-valid" title="<?php echo __('XML verificado automaticamente — destinatário, CFOP e impostos OK'); ?>">
        <i class="icon-ok-sign"></i> <?php echo __('XML validado'); ?>
      </span>
      <?php } ?>
      <?php /* Cliente final: mostra a Declaração de Conteúdo pro agente
               (envio deste chamado é obrigatoriamente pelos CORREIOS) */
      if (zk_ticket_files($tid, 'dc')) {
          echo zk_ticket_dc_html($tid);
          echo '<span class="zk-dc-badge"><i class="icon-user"></i> '.__('Cliente final').'</span>';
      } ?>
      <?php if (zk_ticket_files($tid, 'nf')) { ?>
      <form method="post" action="<?php echo ROOT_PATH; ?>scp/zk-equip.php" class="zk-nf-verify-form">
        <?php csrf_token(); ?>
        <input type="hidden" name="tid" value="<?php echo (int) $tid; ?>">
        <input type="hidden" name="zk_ticket_nf_verify" value="1">
        <button type="submit" class="zk-nf-verify-btn" title="<?php echo __('Verificar XML da Nota Fiscal'); ?>">
          <i class="icon-refresh"></i> <?php echo __('Verificar XML'); ?>
        </button>
      </form>
      <?php } else { ?>
      <form method="post" action="<?php echo ROOT_PATH; ?>scp/zk-equip.php" enctype="multipart/form-data" class="zk-nf-quick-upload-form" id="zkNfQuickUploadFormStaff">
        <?php csrf_token(); ?>
        <input type="hidden" name="tid" value="<?php echo (int) $tid; ?>">
        <label class="zk-nf-quick-upload-btn" title="<?php echo __('Anexar Nota Fiscal (XML)'); ?>">
          <?php /* class="nowarn": ver comentário no painel do cliente. */ ?>
          <i class="icon-paperclip"></i>
          <input type="file" name="zk_ticket_nf" class="nowarn" accept=".xml,text/xml,application/xml" id="zkNfQuickUploadInputStaff">
        </label>
      </form>
      <?php } ?>
      <?php echo zk_nf_dica_html(); ?>
  </div>
  <?php $__zk_nf_errors = zk_ticket_nf_errors_html($tid); if ($__zk_nf_errors) { ?>
  <div class="zk-nf-errors-box">
    <b><?php echo __('Erros encontrados na Nota Fiscal:'); ?></b>
    <?php echo $__zk_nf_errors; ?>
  </div>
  <?php } ?>
  <?php // Envio: mesma regra do painel do cliente — só aparece com a NF
        // validada (ou se já foi informado antes de uma troca de NF).
        // O resumo inclui o estado da confirmação (confirmado em X /
        // aguardando confirmação do envio).
        $__zk_envio_resumo = zk_ticket_envio_resumo($tid, true);
        if (zk_ticket_nf_pendencia($tid) === '' || $__zk_envio_resumo !== '') { ?>
  <div class="zk-envio-bar">
    <span class="zk-envio-label"><i class="icon-truck"></i> <?php echo __('Envio do produto:'); ?></span>
    <?php echo $__zk_envio_resumo !== ''
        ? '<b>'.Format::htmlchars($__zk_envio_resumo).'</b>'
        : '<span class="zk-muted">'.__('não informado pelo solicitante').'</span>'; ?>
  </div>
  <?php } ?>
  <?php echo zk_equip_progress_html($stats); ?>
  <form method="post" action="<?php echo ROOT_PATH; ?>scp/zk-equip.php">
    <?php csrf_token(); ?>
    <input type="hidden" name="tid" value="<?php echo (int) $tid; ?>">
    <?php /* ZK: filtro inteligente (mesmo do painel do cliente) — busca por
             qualquer texto da linha (modelo, nº série, problema, status, laudo). */ ?>
    <div class="zk-toolbar">
      <input type="text" class="zk-search" placeholder="<?php echo __('Buscar por modelo ou nº de série...'); ?>">
    </div>
    <div class="zk-table-wrap">
    <table class="zk-table zk-edit">
      <thead><tr>
        <th class="zk-c-num">#</th>
        <th><?php echo __('Equipamento'); ?></th>
        <th><?php echo __('Problema relatado'); ?></th>
        <th><?php echo __('Status'); ?></th>
        <th><?php echo __('Laudo (visível ao cliente)'); ?></th>
        <th><?php echo __('Nota interna'); ?></th>
      </tr></thead>
      <tbody>
      <?php
      /* Pendência é um conceito do lado do cliente (guia de NF/envio) e é
         gerenciada automaticamente (zk_sync_equip_pendencia) — por isso NÃO
         aparece nem é editável no painel do agente. */
      foreach ($items as $it) { $id = (int) $it['id']; ?>
        <tr class="zk-row">
          <td class="zk-c-num"><?php echo (int) $it['seq']; ?></td>
          <td>
            <b><?php echo Format::htmlchars($it['modelo']); ?></b>
            <?php if ($it['numero_serie'] !== '') echo '<div class="zk-sub zk-muted">S/N: '.Format::htmlchars($it['numero_serie']).'</div>'; ?>
          </td>
          <td>
            <div class="zk-issue-row">
              <div class="zk-issue-text">
                <?php if (!empty($it['resumo'])) echo '<b class="zk-issue-line" title="'.Format::htmlchars($it['resumo']).'">'.Format::htmlchars($it['resumo']).'</b>'; ?>
                <?php if (!empty($it['detalhamento'])) echo '<span class="zk-issue-line zk-sub" title="'.Format::htmlchars($it['detalhamento']).'">'.Format::htmlchars($it['detalhamento']).'</span>'; ?>
              </div>
              <?php $itFiles = isset($files[(int)$it['id']]) ? $files[(int)$it['id']] : array();
                    echo zk_equip_photo_links_html($itFiles); ?>
            </div>
          </td>
          <td>
            <select name="status[<?php echo $id; ?>]" class="zk-status-sel" data-orig="<?php echo Format::htmlchars($it['status']); ?>">
              <?php foreach ($st as $k => $m) {
                  echo '<option value="'.$k.'"'.($k == $it['status'] ? ' selected' : '').'>'.Format::htmlchars($m['label']).'</option>';
              } ?>
            </select>
            <?php /* Mini-barra de evolução do equipamento (peso da etapa);
                     atualiza ao vivo pelo JS ao trocar o status. */
                  $__w = zk_equip_status_weight($it['status']); ?>
            <div class="zk-eqp-mini" title="<?php echo $__w; ?>%"><span style="width:<?php echo $__w; ?>%;background:<?php echo zk_equip_status_color($it['status']); ?>"></span></div>
          </td>
          <td><textarea name="laudo[<?php echo $id; ?>]" rows="2" class="zk-laudo" placeholder="<?php echo __('Laudo / parecer técnico...'); ?>"><?php echo Format::htmlchars($it['laudo']); ?></textarea></td>
          <td><textarea name="nota[<?php echo $id; ?>]" rows="2" class="zk-nota" placeholder="<?php echo __('Uso interno...'); ?>"><?php echo Format::htmlchars($it['nota_interna']); ?></textarea></td>
        </tr>
      <?php } ?>
      </tbody>
    </table>
    </div>
    <div class="zk-actions">
      <?php /* Mudanças de status/laudo geram resposta na thread + e-mail
               ao cliente automaticamente (scp/zk-equip.php) — o antigo
               checkbox "notificar" saiu porque a regra virou sempre-sim. */ ?>
      <span class="zk-notify"><i class="icon-envelope"></i> <?php
        echo __('Mudanças de status e laudo são registradas no chamado e o cliente é notificado por e-mail.'); ?></span>
      <button type="submit" class="zk-save"><?php echo __('Salvar progresso'); ?></button>
    </div>
  </form>
</div>
<script type="text/javascript">
(function($){
  $(function(){
    var $p = $('#zk-staff-panel');
    // Mapa etapa -> {peso, cor} para atualizar a mini-barra sem recarregar.
    var ZK_W = <?php
      $__zkw = array();
      foreach ($st as $k => $m) $__zkw[$k] = array('w' => (int) $m['weight'], 'c' => $m['color']);
      echo json_encode($__zkw); ?>;
    function zkUpdateMini($sel){
      var m = ZK_W[$sel.val()] || {w:0, c:'#9aa0a6'};
      $sel.closest('td').find('.zk-eqp-mini > span').css({width:m.w+'%', background:m.c});
      $sel.closest('td').find('.zk-eqp-mini').attr('title', m.w+'%');
    }
    $p.find('.zk-status-sel').on('change', function(){
      $(this).toggleClass('zk-changed', $(this).val() !== $(this).data('orig'));
      zkUpdateMini($(this));
    });
    // ZK: filtro inteligente (mesmo do painel do cliente) — busca por qualquer
    // texto da linha (modelo, nº série, problema, status, laudo, nota).
    $p.find('.zk-search').on('keyup', function(){
      var q = $(this).val().toLowerCase();
      $p.find('tbody tr.zk-row').each(function(){
        $(this).toggle($(this).text().toLowerCase().indexOf(q) > -1);
      });
    });
    // Anexar NF direto do painel (agente) — mesmo esquema do painel do cliente.
    $('#zkNfQuickUploadInputStaff').on('change', function(){
      var file = this.files && this.files[0];
      if (file && !/\.xml$/i.test(file.name)) {
        alert('<?php echo __('A Nota Fiscal precisa ser um arquivo .xml.'); ?>');
        $(this).val('');
        return;
      }
      // Submit via jQuery — passa pelo handler do core que desliga o
      // aviso "Sair do site?" (mesmo motivo do painel do cliente).
      if (file) $('#zkNfQuickUploadFormStaff').trigger('submit');
    });
  });
})(jQuery);
</script>
    <?php
}
