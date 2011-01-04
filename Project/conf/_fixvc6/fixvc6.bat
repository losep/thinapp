@echo off
setlocal
set src=%~dp0
if not ""=="%1" set dst=%~1\
for %%i in ("%%Drive_c%%" "%%SystemSystem%%") do (
    xcopy "%src%%%~i" "%dst%%%~i" /Y /I /D /E /K /F
)
xcopy "%src%fixvctools.bat" "%dst%" /D /K /F
endlocal
