/*
Execute This Script to Update all your files in the script folder
*/
Inputbox, UserInput, Git Pull, Type "yes" to pull from git.

If (UserInput == "yes"){
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/MainScriptOSRS.ahk , MainScriptOSRS.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Globalpullvariables.ahk , Globalpullvariables.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Functions.ahk , Functions.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Gui.ahk , Gui.ahk ;pulls the file

msgbox, Updated.`nYou can execute MainScriptOSRS.ahk now.
}
else
{
msgbox, Not Pulled.
}
