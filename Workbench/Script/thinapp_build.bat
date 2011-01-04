@echo off
setlocal
set dp=%~dp0

if "/f"=="%~1" set _bcleanup=1
if "/?"=="%~1" goto usage
goto start
:usage
echo %0
echo Usage: 
echo   %0 [Options]
echo Options:
echo   /? help
echo   /f do cleanup
goto end

:start
set PROJECT_DIR=%PROJECT_PATH%
if exist %PROJECT_PATH% goto haspath
set PROJECT_DIR=%CD%
:haspath
set _bstep=Build Step 0 - Thinapp path searching
echo %_bstep%
if exist "%THINSTALL_BIN%\vregtool.exe" goto found
set %THINSTALL_BIN%=%PROJECT_DIR%
if exist "%THINSTALL_BIN%\vregtool.exe" goto found
set %THINSTALL_BIN%=%~dp0
if exist "%THINSTALL_BIN%\vregtool.exe" goto found
goto failed


:found
if not exist "%THINSTALL_BIN%\vftool.exe" goto failed
if not exist "%THINSTALL_BIN%\tlink.exe" goto failed

if not exist "%PROJECT_DIR%\bin" mkdir "%PROJECT_DIR%\bin"
if exist "%PROJECT_DIR%\bin\*.exe" del /f /q "%PROJECT_DIR%\bin\*.exe"


set _bstep=Build Step 1 - Registry creating
echo %_bstep%
"%THINSTALL_BIN%\vregtool" "%PROJECT_DIR%\bin\Package.ro.tvr" ImportDir "%PROJECT_DIR%"
IF ERRORLEVEL 1 GOTO failed

set _bstep=Build Step 2 - File system creating
echo %_bstep%
"%THINSTALL_BIN%\vftool" "%PROJECT_DIR%\bin\Package.ro.tvr" ImportDir "%PROJECT_DIR%"
IF ERRORLEVEL 1 GOTO failed

set _bstep=Build Step 3 - Programs linking
echo %_bstep%
"%THINSTALL_BIN%\tlink" "%PROJECT_DIR%\Package.ini" -OutDir "%PROJECT_DIR%\bin"
IF ERRORLEVEL 1 GOTO failed

if ""=="%_bcleanup%" goto done
set _bstep=Build Step 4 - Cleaning up
del "%PROJECT_DIR%\bin\*.tvr"
del "%PROJECT_DIR%\bin\*.tvr.thfd"
goto done

:failed
echo *** Build failed ***
echo * %_bstep%
echo ********************
goto final

:done
echo ---------------------------------------------
echo Build complete
:final


