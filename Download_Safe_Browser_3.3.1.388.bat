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
if exist %USERPROFILE%\Downloads\SEB_3.3.1.388.exe (
    echo "Found SEB_3.3.1.388.exe" no need to Download again
    echo Start Install SafeExamBrowser "please wait a moment until finish install"
    set "SafeExamBrowserInstallDir=%PROGRAMFILES%\SafeExamBrowser"
    %USERPROFILE%\Downloads\SEB_3.3.1.388.exe /silent /norestart TargetDir="%SafeExamBrowserInstallDir%"
) else (
    echo "Download SafeExamBrowser_3.3.1.388.exe it's 194.234 MB maybe take two minutes please wait until finish Download"
    curl "https://moodle2.bgu.ac.il/moodle/pluginfile.php/2319634/course/section/532495/SEB_3.3.1.388.exe" --output %USERPROFILE%\Downloads\SEB_3.3.1.388.exe
    echo Start Install SafeExamBrowser "please wait a minutes"
    set "SafeExamBrowserInstallDir=%PROGRAMFILES%\SafeExamBrowser"
    %USERPROFILE%\Downloads\SEB_3.3.1.388.exe /silent /norestart TargetDir="%SafeExamBrowserInstallDir%"
)
echo "finish installing"
if exist %USERPROFILE%\Downloads\SebClientSettings.seb (
    echo "Found SebClientSettings.seb" no need to Download again
) else (
    echo "Download SebClientSettings.seb it's 2.93 KB please wait until finish Download"
    curl "https://moodle2.bgu.ac.il/moodle/pluginfile.php/2625864/mod_resource/content/4/SebClientSettings.seb" --output %USERPROFILE%\Downloads\SebClientSettings.seb
)
echo.
cd %PROGRAMFILES%\SafeExamBrowser\Application\
start SafeExamBrowser.exe %USERPROFILE%\Downloads\SebClientSettings.seb
echo.
xcopy "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Safe Exam Browser.lnk" "%USERPROFILE%\DESKTOP" /s
echo.
echo.
echo "Thanks you "
echo "have a Nice Day!"
echo.
echo.
pause
