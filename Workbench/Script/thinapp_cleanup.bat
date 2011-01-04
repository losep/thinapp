@echo off

set PROJECT_DIR=%PROJECT_PATH%
if exist %PROJECT_PATH% goto haspath
set PROJECT_DIR=%CD%
:haspath

del "%PROJECT_DIR%\bin\*.tvr"
del "%PROJECT_DIR%\bin\*.tvr.thfd"

:done
echo Build Step [4/4] : CleanUp complete

:final
