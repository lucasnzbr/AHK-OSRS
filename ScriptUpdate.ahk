/*
Execute This Script to Update all your files in the script folder
*/
Inputbox, UserInput, Git Pull, Type "yes" to pull from git.

If (UserInput == "yes"){
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/MainScriptOSRS.ahk , MainScriptOSRS.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Globalpullvariables.ahk , Globalpullvariables.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Functions.ahk , Functions.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Gui.ahk , Gui.ahk ;pulls the file


;Scripts Folder
scriptDir := A_ScriptDir
folderPath := scriptDir . "\Scripts"
if not FileExist(folderPath)
    FileCreateDir, %folderPath%

UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/AutoClickParaTele.ahk, Scripts\AutoClickParaTele.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/BlastFurnaceBeta.ahk, Scripts\BlastFurnaceBeta.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/ClickEveryXsecondsAndPressSpace.ahk, Scripts\ClickEveryXsecondsAndPressSpace.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/Construction.ahk, Scripts\Construction.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/CraftingMix.ahk, Scripts\CraftingMix.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/Cyberthiev.ahk, Scripts\Cyberthiev.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/Firemaking.ahk, Scripts\Firemaking.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/Fishing.ahk, Scripts\Fishing.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/FletchingMix.ahk, Scripts\FletchingMix.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/HerbloreMixV1.2.ahk, Scripts\HerbloreMixV1.2.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/HunterV1.4WorkingAndTested.ahk, Scripts\HunterV1.4WorkingAndTested.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/LavaRunes.ahk, Scripts\LavaRunes.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/MiningIron2Spots1080p.ahk, Scripts\MiningIron2Spots1080p.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/MiningIron3SpotsDropMaisRapido1080p.ahk, Scripts\MiningIron3SpotsDropMaisRapido1080p.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/PixelgetcolorOnF1.ahk, Scripts\PixelgetcolorOnF1.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/PrayerMaisRapido.ahk, Scripts\PrayerMaisRapido.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/SandCrabsV2.0.ahk, Scripts\SandCrabsV2.0.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/SmithingVarrockWest.ahk, Scripts\SmithingVarrockWest.ahk ;pulls the file
UrlDownloadToFile, https://raw.githubusercontent.com/lucasnzbr/AHK-OSRS/main/Scripts/WcAdaptadoDoMining.ahk, Scripts\WcAdaptadoDoMining.ahk ;pulls the file



msgbox, Updated.`nYou can execute MainScriptOSRS.ahk now.
}
else
{
msgbox, Not Pulled.
}
