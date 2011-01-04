@echo off
setlocal
if not exist start.snapshot goto no0
goto start
:no0
if not exist ..\start.snapshot goto no1
copy ..\start.snapshot
goto start
:no1
if not exist ..\..\start.snapshot goto no2
copy ..\..\start.snapshot
goto start
:no2
if not exist \start.snapshot goto no3
copy \start.snapshot
goto start
:no3
echo No start.snapshot found
echo %0 WILL ABORT
goto abort

:start
echo *** snapshot end.snapshot
@pause
snapshot end.snapshot

echo *** snapshot start.snapshot -SuggestProject end.snapshot Template.ini
@pause
snapshot start.snapshot -SuggestProject end.snapshot Template.ini

echo *** snapshot Template.ini -GenerateProject .
@pause
snapshot Template.ini -GenerateProject .

echo ----------------------------------------------
echo snapshots done.
echo runing build.bat or thinapp_build.bat to build 
echo the project
echo.
:end
:abort
