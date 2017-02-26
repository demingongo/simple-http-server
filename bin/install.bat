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
for /f "tokens=1,2 delims=:, " %%a in (' find ":" ^< "package.json" ') do set "%%~a=%%~b"
IF "%name%"=="" set name=%CurrDirName%
set DEBUG=%name%:*
npm install
