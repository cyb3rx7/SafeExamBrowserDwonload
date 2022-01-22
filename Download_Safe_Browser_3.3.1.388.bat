@echo off
title Install SafeExamBrowser
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
echo "Create Folder on Desktop with name and start downloads and install SafeExamBrowser on Desktop"
mkdir %USERPROFILE%\DESKTOP\SafeExamBrowser"
cd  %USERPROFILE%\DESKTOP\SafeExamBrowser"
echo.
echo "Download SafeExamBrowser_3.3.1.388.exe it's 194.234 MB maybe take two minutes so please wait"
curl "https://moodle2.bgu.ac.il/moodle/pluginfile.php/2319634/course/section/532495/SEB_3.3.1.388.exe" --output SEB_3.3.1.388.exe
echo.
echo "Download SebClientSettings.seb it's 2.93 KB"
curl "https://moodle2.bgu.ac.il/moodle/pluginfile.php/2625864/mod_resource/content/4/SebClientSettings.seb" --output SebClientSettings.seb
echo.
set "SafeExamBrowserInstallDir=%PROGRAMFILES%\SafeExamBrowser"
%USERPROFILE%\DESKTOP\SafeExamBrowser\SEB_3.3.1.388.exe /silent /norestart TargetDir="%SafeExamBrowserInstallDir%"
echo.
cd %PROGRAMFILES%\SafeExamBrowser\Application\
start SafeExamBrowser.exe %USERPROFILE%\DESKTOP\SafeExamBrowser\SebClientSettings.seb
echo.
cp -r "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Safe Exam Browser.lnk" "%USERPROFILE%\DESKTOP"
echo.
echo.
echo "Thanks you "
echo "have a Nice Day!"
echo.
echo.
echo //TODO
echo Convert a Batch File to EXE - IExpress 2.0
echo fix open with (SebClientSettings) regedit
echo but get (Access is denied.)
echo after put command inside script idk why 
echo still look around to fix it 
echo or just look for other way
pause
