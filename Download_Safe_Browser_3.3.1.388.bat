@echo off

echo "Create Folder on Desktop with name SafeExamBrowser"
mkdir %USERPROFILE%\DESKTOP\SafeExamBrowser"

echo "Open Folder on Desktop name SafeExamBrowser"
cd  %USERPROFILE%\DESKTOP\SafeExamBrowser"

echo "Download SafeExamBrowser_3.3.1.388.exe it's 194.234 MB maybe take some tiime so pleses wait"
curl "https://moodle2.bgu.ac.il/moodle/pluginfile.php/2319634/course/section/532495/SEB_3.3.1.388.exe" --output SEB_3.3.1.388.exe

echo "Download SebClientSettings.seb it's 2.93 KB"
curl "https://moodle2.bgu.ac.il/moodle/pluginfile.php/2625864/mod_resource/content/4/SebClientSettings.seb" --output SebClientSettings.seb

pause
