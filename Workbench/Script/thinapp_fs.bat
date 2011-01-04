@echo off
set exe=vftool.exe

set PROJECT_DIR=%PROJECT_PATH%
if exist %PROJECT_PATH% goto haspath
set PROJECT_DIR=%CD%
:haspath

if exist "%THINSTALL_BIN%\%exe%" goto found
set %THINSTALL_BIN%=%PROJECT_DIR%
if exist "%THINSTALL_BIN%\%exe%" goto found
set %THINSTALL_BIN%=%~dp0
if exist "%THINSTALL_BIN%\%exe%" goto found
goto start

:found
set exe=%THINSTALL_BIN%\%exe%

:start

if not exist "%PROJECT_DIR%\bin" mkdir "%PROJECT_DIR%\bin"
if exist "%PROJECT_DIR%\bin\*.exe" del /f /q "%PROJECT_DIR%\bin\*.exe"

"%exe%" "%PROJECT_DIR%\bin\Package.ro.tvr" ImportDir "%PROJECT_DIR%"
IF ERRORLEVEL 1 GOTO failed


goto done

:failed
echo *** Build Step 2 [FileSystem] failed ***
goto final

:done
echo Build Step 2 [FileSystem] complete
:final
