@echo off
tasklist | find /I "notepad.exe"
if %errorlevel%==0 (
echo proceso ejecutandose
pause > nul
) else (
echo proceso no ejecutado
pause > nul
)