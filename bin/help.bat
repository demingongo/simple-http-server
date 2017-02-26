@echo off
REM Have node and npm installed
set CurrDir=%CD%
for %%* in (.) do set CurrDirName=%%~nx*
if "%CurrDirName%"=="bin" goto changeDir
goto npmStart

:changeDir
set ProjPath=%CD:~0,-4%
cd %ProjPath%
for %%* in (.) do set CurrDirName=%%~nx*
goto npmStart

:npmStart
start cmd /k node --help
