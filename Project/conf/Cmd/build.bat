@echo off

set PROJECT_DIR=%PROJECT_PATH%
if exist %PROJECT_PATH% goto haspath
set PROJECT_DIR=%~dp0
:haspath

if exist "%THINSTALL_BIN%\vregtool.exe" goto found
set THINSTALL_BIN=%PROJECT_DIR%\..\..
if exist "%THINSTALL_BIN%\vregtool.exe" goto found
set "THINSTALL_BIN=L:\WorkBench\Thinapp"
if exist "%THINSTALL_BIN%\vregtool.exe" goto found
set "THINSTALL_BIN=C:\Program Files\VMware\VMware ThinApp"
if exist "%THINSTALL_BIN%\vregtool.exe" goto found
echo Could not find vregtool.exe, please set the environment variable THINSTALL_BIN or install to C:\Program Files\VMware\VMware ThinApp
goto failed

:found
if not exist "%THINSTALL_BIN%\vftool.exe" goto failed
if not exist "%THINSTALL_BIN%\tlink.exe" goto failed

if not exist "%PROJECT_DIR%\bin" mkdir "%PROJECT_DIR%\bin"
if exist "%PROJECT_DIR%\bin\*.exe" del /f /q "%PROJECT_DIR%\bin\*.exe"

"%THINSTALL_BIN%\vregtool" "%PROJECT_DIR%\bin\Package.ro.tvr" ImportDir "%PROJECT_DIR%"
IF ERRORLEVEL 1 GOTO failed

"%THINSTALL_BIN%\vftool" "%PROJECT_DIR%\bin\Package.ro.tvr" ImportDir "%PROJECT_DIR%"
IF ERRORLEVEL 1 GOTO failed

"%THINSTALL_BIN%\tlink" "%PROJECT_DIR%\Package.ini" -OutDir "%PROJECT_DIR%\bin"
IF ERRORLEVEL 1 GOTO failed

goto done

:failed
echo *** Build failed ***
goto final

:done
sleep 3
del "%PROJECT_DIR%\bin\*.tvr"
del "%PROJECT_DIR%\bin\*.tvr.thfd"
echo ---------------------------------------------
echo Build complete
:final
pause