@echo off

setlocal

DEL log.txt >NUL 2>NUL
DEL incbin.asm >NUL 2>NUL
DEL SoldierBlade_SNESPAD.pce >NUL 2>NUL
DEL SoldierBlade_SNESPAD.sym >NUL 2>NUL

set arg1=%1

if "%arg1%"=="" (
    echo.
    echo.
    echo Please provide a path to the rom file for modification.
    echo.
    echo     E.g.  patch_SoldierBlade_rom.bat  myRomFile.pce
    echo.
    echo.
    echo.
    echo NOTE: The rom file format needs to be headerless. File size should be even multiple of 1024 bytes.
    echo       If using a US dumped rom, it must NOT be bit-swapped. There are still bit-swapped US romsets floating around.
    echo       US dumped roms that are not bit-swapped are usually noted with a "[h1].pce"
    echo       JP dumped roms are not typically bit-swapped.
    echo.
    echo       There are tools for removing headers and bit-swapping in the Tools folder.
    echo.
    pause
    exit 1
) else (
    echo .incbin "%1" > incbin.asm
)

for %%A in ("%arg1%") do set "size=%%~zA"

set "num2=1024"
set /A "result=size %% num2"

if "%result%" NEQ "0" (
    echo.
    echo.
    echo Error: A header was detected in the rom file. Please use a headerless rom or remove the first 512bytes from the file.
    echo.
    pause
    exit 1
)

pceas -raw SoldierBlade_JP_SNESPAD.asm > log.txt
set "errorlevel=%ERRORLEVEL%"
if "%errorlevel%"=="0" (
    echo.
    echo PCEAS successfully patched the JP rom file.
    echo.
) else (
    echo.
    echo PCEAS failed to patch the rom file. Check the log file for details.
    echo.
    pause
    exit 1
)

endlocal
pause
