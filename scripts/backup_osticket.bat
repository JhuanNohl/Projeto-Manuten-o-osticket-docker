@echo off
REM Gera um dump do banco do CONTAINER em backups\ com data/hora no nome.
cd /d "%~dp0.."
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set TS=%%i
set OUT=backups\backup_%TS%.sql
echo Gerando backup em %OUT% ...
docker compose exec -T db sh -c "exec mariadb-dump -u root -p\"$MARIADB_ROOT_PASSWORD\" --single-transaction --hex-blob --default-character-set=utf8 \"$MARIADB_DATABASE\"" > "%OUT%"
if errorlevel 1 (
  echo ERRO ao gerar backup. O ambiente esta rodando? ^(iniciar_osticket.bat^)
  pause
  exit /b 1
)
echo.
echo Backup concluido: %OUT%
pause
