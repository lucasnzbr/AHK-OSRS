/*
Execute This Script to Update all your files in the script folder
*/
#include,Globalpullvariables.ahk
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Globalpullvariables.ahk , Globalpullvariables.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/MainScriptOSRS.ahk , MainScriptOSRS.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Functions.ahk , Functions.ahk ;pulls the file


msgbox, Updated to version %currentversion%`n`You can execute MainScriptOSRS.ahk now.
