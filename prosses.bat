tasklist | find /i "notepad.exe" && (
echo. El proceso está ejecutandose.
pause > nul
) || (
echo El proceso no se esta ejecutando.
pause > nul
)
exit /b 0