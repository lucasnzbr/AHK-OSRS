
Gui, Add, DropDownList, x82 y9 w110 h20 , DropDownList
Gui, Add, Text, x52 y39 w80 h20 , Quantity of bars
Gui, Add, Edit, x132 y39 w40 h20 , Edit
Gui, Add, Text, x22 y69 w100 h20 +Uppercase   +Right, Stamina pot(1) - F3
Gui, Add, Button, x132 y69 w20 h20 , ? f3
Gui, Add, Text, x22 y99 w100 h20 +Right, Ore 1(Bank) - F4
Gui, Add, Button, x132 y99 w20 h20 , ? f4
Gui, Add, Text, x12 y229 w120 h20 +Right, Coffer - F8
Gui, Add, Button, x142 y169 w20 h20 , ? f6
Gui, Add, Text, x12 y169 w120 h20 +Right, Conveyor Belt x1y1 - F6
Gui, Add, Text, x12 y199 w120 h20 +Right, Conveyor Belt x2y2 - F7
Gui, Add, Button, x142 y229 w20 h20 , ? f8
Gui, Add, Text, x12 y9 w60 h20 , Select Script
Gui, Add, GroupBox, x12 y59 w240 h100 ,
Gui, Add, Text, x172 y99 w70 h20 , OPEN BANK
Gui, Add, Button, x142 y199 w20 h20 , ? f7
Gui, Add, Button, x132 y129 w20 h20 , ? f5
Gui, Add, Text, x22 y129 w100 h20 +Right, Ore 2(Bank) - F5
Gui, Add, Button, x206 y-53 w-44 h152 , Script Info
Gui, Add, Text, x182 y179 w70 h50 , CLOSE BANK INTERFACE`, STAND ON BANK SPOT
Gui, Add, GroupBox, x12 y159 w240 h90 ,
Gui, Add, Text, x12 y269 w120 h20 +Right, Bar Dispenser x1y1 - F9
Gui, Add, Text, x12 y299 w120 h20 +Right, Bar Dispenser x2y2 - F10
Gui, Add, Text, x22 y339 w110 h20 +Right, Bank x1y1 - F11
Gui, Add, Text, x22 y369 w110 h20 +Right, Bank x2y2 - F12
Gui, Add, GroupBox, x12 y259 w240 h70 ,
Gui, Add, Text, x182 y279 w60 h40 , STAND ON CONVEYOR BELT
Gui, Add, Button, x142 y269 w20 h20 , ? F9
Gui, Add, Button, x142 y299 w20 h20 , ? f10
Gui, Add, Button, x142 y339 w20 h20 , ? F11
Gui, Add, Button, x142 y369 w20 h20 , ? f12
Gui, Add, Text, x182 y349 w70 h40 , STAND ON DISPENSER
Gui, Add, GroupBox, x12 y329 w240 h70 ,
Gui, Add, Button, x12 y399 w110 h40 , Runelite Optimal setup. (Suggested`, not required)
Gui, Add, Button, x142 y399 w110 h40 , Start(F1)
Gui, Add, Button, x202 y9 w60 h20 , Script Info
Gui, Show, w273 h459, Untitled GUI
return

GuiClose:
ExitApp