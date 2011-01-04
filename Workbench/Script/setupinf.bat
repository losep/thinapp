@echo off
setlocal
set setup_cmd=%SystemRoot%\System32\rundll32.exe setupapi,InstallHinfSection DefaultInstall 132

:setup
if "%~1"=="" goto end_setup
if exist %1 goto setupdir
echo %setup_cmd% "%~1"
%setup_cmd% "%~1"
shift
goto setup

:setupdir
for %%i in ( "%~1*.inf" ) do (
    echo %setup_cmd% %%i
    %setup_cmd% %%i
)
shift
goto setup

:end_setup
:end
endlocal
if "%master%"=="" pause