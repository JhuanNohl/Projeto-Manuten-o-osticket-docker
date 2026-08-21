@echo off
REM Restaura um arquivo .sql para DENTRO do banco do container.
REM ATENCAO: SOBRESCREVE os dados atuais do banco no container.
cd /d "%~dp0.."
set /p FILE="Caminho do arquivo .sql (ex: backups\backup_20260707_120000.sql): "
if not exist "%FILE%" (
  echo Arquivo nao encontrado: %FILE%
  pause
  exit /b 1
)
echo.
echo *** ATENCAO ***  Isto vai SOBRESCREVER o banco atual do container.
echo Arquivo: %FILE%
set /p OK="Digite SIM para confirmar: "
if /I not "%OK%"=="SIM" (
  echo Cancelado.
  pause
  exit /b 0
)
echo Restaurando...
docker compose exec -T db sh -c "exec mariadb -u root -p\"$MARIADB_ROOT_PASSWORD\" \"$MARIADB_DATABASE\"" < "%FILE%"
if errorlevel 1 (
  echo ERRO na restauracao.
  pause
  exit /b 1
)
echo.
echo Restauracao concluida.
pause
