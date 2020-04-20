rem @echo off 
REM x:
SET TOOLSDRV=x:
SET VASM=%TOOLSDRV%\Utils\Vasm\vasmm68k_mot_win32.exe
SET VLINK=%TOOLSDRV%\Utils\Vasm\vlink.exe
cls
REM cd \Sources\AtariST\ShaneSrc\Sudoku
if not exist .\OBJ mkdir OBJ
if not exist .\LIST mkdir LIST
if not exist .\BIN mkdir BIN

del /f /q OBJ\*.*
del /f /q LIST\*.*
del /f /q BIN\*.*
del /f /q x:\RelAST\*.*

SET SRCFILE=Main
%VASM% %SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=FindNextEmpty
%VASM% %SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=Grid1
%VASM% %SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=PrintPuzzle
%VASM% %SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=SolveSudoku
%VASM% %SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=Sudoku_Solver
%VASM% %SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=Sudoku_Solver_globals
%VASM% %SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=RegisterDump
%VASM% ..\Library\%SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=BasicPrintToScreen
%VASM% ..\Library\%SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=ReturnToOS
%VASM% ..\Library\%SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=PrintHex
%VASM% ..\Library\%SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon

SET SRCFILE=MemoryDump
%VASM% ..\Library\%SRCFILE%.asm -chklabels -nocase -Dvasm=1  -L LIST\%SRCFILE%.txt -DBuildAST=1 -Felf -o OBJ\%SRCFILE%.ELF
if not "%errorlevel%"=="0" goto Abandon


cd OBJ
%VLINK% -o..\BIN\Prog.tos -bataritos Main.ELF FindNextEmpty.ELF Grid1.ELF PrintPuzzle.ELF SolveSudoku.ELF Sudoku_Solver.ELF RegisterDump.ELF BasicPrintToScreen.ELF ReturnToOS.ELF PrintHex.ELF Sudoku_Solver_globals.ELF MemoryDump.ELF
cd ..
if not "%errorlevel%"=="0" goto Abandon

if NOT "%1%"=="emu" goto Abandon
copy BIN\Prog.tos %TOOLSDRV%\RelAST
copy X:\Emu\Steem\Restore_auto.sts X:\Emu\Steem\auto.sts
start X:\Emu\Steem\Steem.exe
rem exit
:Abandon
REM if "%3"=="nopause" exit
REM pause
