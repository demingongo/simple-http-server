@ECHO OFF
REM Have node and npm installed

SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

REM Prepare a file "X" with only one dot
<nul > X set /p ".=."
for %%* in (.) do set CurrDirName=%%~nx*
set XDir=.\
if "%CurrDirName%"=="bin" goto CHANGEDIR
goto CONFIG

:CHANGEDIR
set XDir=bin\
set ProjPath=%CD:~0,-4%
cd %ProjPath%
for %%* in (.) do set CurrDirName=%%~nx*
goto CONFIG


:CONFIG
call :COLOR 0b "Simple Http Server    "
echo.
if not exist "./www/" (
      set errorMessage=Could not find root www
      goto ERR
)
set port=8080
echo Port? (8080)
set/p "port=>"
goto LAUNCH

:LAUNCH
echo %port%| findstr /r "^[1-9][0-9]*$">nul
if %errorlevel% equ 0 (
    echo port : %port%
    @SETLOCAL
    @SET PATHEXT=%PATHEXT:;.JS;=;%
    REM http-server -a 0.0.0.0 -p 8080
    if exist "./node_modules/http-server/bin/http-server" (
      start cmd /k node "./node_modules/http-server/bin/http-server" ./www -a 0.0.0.0 -p %port%
    ) else (
      start cmd /k node http-server ./www -a 0.0.0.0 -p %port%
    )
) else (
    set errorMessage=Invalid port number
    goto ERR
)
goto END

:COLOR
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\%XDir%X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
exit /b

:ERR
call :COLOR 0c "%errorMessage%    "
echo.
pause
goto END

:END?