rem @echo off 
x:
cls
cd \Sources\AtariST\ShaneSrc\DbccTest
if not exist .\OBJ mkdir OBJ
if not exist .\LIST mkdir LIST
if not exist .\BIN mkdir BIN

del /f /q OBJ\*.*
del /f /q LIST\*.*
del /f /q BIN\*.*
del /f /q \RelAST\*.*

SET SRCFILE=Main
\Utils\Vasm\vasmm68k_mot_win32.exe %SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=RegisterDump
\Utils\Vasm\vasmm68k_mot_win32.exe ..\Library\%SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=BasicPrintToScreen
\Utils\Vasm\vasmm68k_mot_win32.exe ..\Library\%SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=ReturnToOS
\Utils\Vasm\vasmm68k_mot_win32.exe ..\Library\%SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=PrintHex
\Utils\Vasm\vasmm68k_mot_win32.exe ..\Library\%SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=MemoryDump
\Utils\Vasm\vasmm68k_mot_win32.exe ..\Library\%SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon


cd OBJ
\Utils\Vasm\vlink.exe -o..\BIN\Prog.tos -bataritos Main.ELF RegisterDump.ELF BasicPrintToScreen.ELF ReturnToOS.ELF PrintHex.ELF MemoryDump.ELF
cd ..
if not "%errorlevel%"=="0" goto Abandon

if NOT "%1%"=="emu" goto Abandon
copy BIN\Prog.tos \RelAST
copy X:\Emu\Steem\Restore_auto.sts X:\Emu\Steem\auto.sts
start X:\Emu\Steem\Steem.exe
rem exit
:Abandon
REM if "%3"=="nopause" exit
REM pause
