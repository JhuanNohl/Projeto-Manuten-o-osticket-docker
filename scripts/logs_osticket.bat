@echo off
REM Mostra os logs ao vivo dos dois containers (Ctrl+C para sair).
cd /d "%~dp0.."
echo Logs ao vivo (Ctrl+C para sair)...
docker compose logs -f --tail=100
