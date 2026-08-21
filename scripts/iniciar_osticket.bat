@echo off
REM Sobe o ambiente osTicket (app + banco). Na 1a vez a imagem e' construida
REM e o banco e' restaurado automaticamente a partir de db\init\*.sql
cd /d "%~dp0.."
echo Iniciando osTicket (Docker)...
docker compose up -d
if errorlevel 1 (
  echo.
  echo ERRO ao iniciar. O Docker Desktop esta aberto/rodando?
  pause
  exit /b 1
)
echo.
echo Pronto. Acesse:  http://localhost:8080
echo Painel da equipe: http://localhost:8080/scp/
echo.
pause
