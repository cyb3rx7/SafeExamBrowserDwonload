@echo off

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
echo "Create Folder on Desktop with name SafeExamBrowser on Desktop"

mkdir %USERPROFILE%\DESKTOP\SafeExamBrowser"

echo "Open Folder on Desktop name SafeExamBrowser"

cd  %USERPROFILE%\DESKTOP\SafeExamBrowser"

echo "Download SafeExamBrowser_3.3.1.388.exe it's 194.234 MB maybe take five minutes so please wait"

curl "https://moodle2.bgu.ac.il/moodle/pluginfile.php/2319634/course/section/532495/SEB_3.3.1.388.exe" --output SEB_3.3.1.388.exe

echo "Download SebClientSettings.seb it's 2.93 KB"

curl "https://moodle2.bgu.ac.il/moodle/pluginfile.php/2625864/mod_resource/content/4/SebClientSettings.seb" --output SebClientSettings.seb
:--------------------------------------
echo "install SafeExamBrowser to location C:\Program Files\SafeExamBrowser.exe"

set "SafeExamBrowserInstallDir=C:\Program Files\SafeExamBrowser"
%USERPROFILE%\DESKTOP\SafeExamBrowser\SEB_3.3.1.388.exe /silent /norestart TargetDir="%SafeExamBrowserInstallDir%"

echo "open SebClientSettings.seb with SafeExamBrowser.exe"

"C:\Program Files\SafeExamBrowser\Application\SafeExamBrowser.exe" -U user -d dbName -f "%USERPROFILE%\DESKTOP\SafeExamBrowser\SebClientSettings.seb"

echo "copy SafeExamBrowser to Desktop"

cp -r "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Safe Exam Browser.lnk" "%USERPROFILE%\DESKTOP"
pause