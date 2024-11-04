@echo off

setlocal

DEL log.txt >NUL 2>NUL

python --version
set "errorlevel=%ERRORLEVEL%"
if "%errorlevel%"=="0" (
    echo.
) else (
    echo.
    echo Python does not appear to be installed or accessible from this batch file.
    echo Cannot complete operation. Try installing python with the full-path option.
    echo.
    pause
    exit 1
)

python bitSwap.py --input %1 --check > log.txt
type log.txt

endlocal
pause
