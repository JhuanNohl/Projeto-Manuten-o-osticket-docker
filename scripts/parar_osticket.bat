@echo off
REM Para os containers SEM apagar dados (o volume do banco e' preservado).
cd /d "%~dp0.."
echo Parando osTicket...
docker compose stop
echo.
echo Containers parados. Os dados continuam salvos.
echo (Para iniciar de novo: iniciar_osticket.bat)
pause
