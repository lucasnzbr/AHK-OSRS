#Include,Globalpullvariables.ahk ;Useful for testing purposes, redundant if executing from Main Script.
#SingleInstance,force
Gui, Add, Tab2, x0 y0 w370 h617 , Combat|Gathering|Production|Utility Skills|Money Making|Info
Gui, Tab, Combat
Gui, Add, Text, x12 y589 w130 h20 , Script Version = %currentversion%
Gui, Add, Text, x12 y569 w110 h20 , Coffee Scripts OSRS
Gui, Add, Text, x32 y79 w100 h60 +Left, Attack/Strength/`nDefence/Hitpoints/`nMagic/Prayer/`nRanged
Gui, Tab, Gathering
Gui, Add, Text, x12 y589 w130 h20 , Script Version = %currentversion%
Gui, Add, Text, x12 y569 w110 h20 , Coffee Scripts OSRS
Gui, Add, Text, x32 y450 w100 h60 +Left, Farming/Fishing/`nHunter/Mining`nWoodcutting
Gui, Add, button, x12 y49 w120 h20 ghuntersalamanders, Hunter - Salamanders
Gui, Add, button, x142 y49 w20 h20 ginfohuntersalamanders, ?
Gui, Tab, Production
Gui, Add, Text, x12 y589 w130 h20 , Script Version = %currentversion%
Gui, Add, Text, x12 y569 w110 h20 , Coffee Scripts OSRS
Gui, Add, Text, x32 y79 w100 h60 +Left, Cooking/Crafting`nFletching/Herblore`nRunecraft/Smithing
Gui, Tab, Utility Skills
Gui, Add, Text, x12 y589 w130 h20 , Script Version = %currentversion%
Gui, Add, Text, x12 y569 w110 h20 , Coffee Scripts OSRS
Gui, Add, Text, x32 y79 w100 h60 +Left, Agility/Construction`nFiremaking/Slayer`nThieving
Gui, Tab, Money Making
Gui, Add, Text, x12 y589 w130 h20 , Script Version = %currentversion%
Gui, Add, Text, x12 y569 w110 h20 , Coffee Scripts OSRS
Gui, Add, Text, x32 y79 w100 h60 +Left, Maple Cutting/Potions`nCannonballs`nOutros
Gui, Tab, Info
Gui, Add, Text, x12 y589 w130 h20 , Script Version = %currentversion%
Gui, Add, Text, x12 y569 w110 h20 , Coffee Scripts OSRS
Gui, Add, Text, x32 y79 w100 h60 +Left, About The Script
Gui, Show, x1500 y0 w370 h617, COFFEE SCRIPTS OSRS
gui,+alwaysontop
return
GuiClose:
ExitApp
