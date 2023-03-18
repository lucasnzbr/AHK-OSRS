#SingleInstance, force
coordmode, mouse, screen
;Functions
RandomBezier( X0, Y0, Xf, Yf, O="" ) {

    Time := RegExMatch(O,"i)T(\d+)",M)&&(M1>0)? M1: 200
    RO := InStr(O,"RO",0) , RD := InStr(O,"RD",0)
    N:=!RegExMatch(O,"i)P(\d+)(-(\d+))?",M)||(M1<2)? 2: (M1>19)? 19: M1
    If ((M:=(M3!="")? ((M3<2)? 2: ((M3>19)? 19: M3)): ((M1=="")? 5: ""))!="")
        Random, N, %N%, %M%
    OfT:=RegExMatch(O,"i)OT(-?\d+)",M)? M1: 100, OfB:=RegExMatch(O,"i)OB(-?\d+)",M)? M1: 100
    OfL:=RegExMatch(O,"i)OL(-?\d+)",M)? M1: 100, OfR:=RegExMatch(O,"i)OR(-?\d+)",M)? M1: 100
    MouseGetPos, XM, YM
    If ( RO )
        X0 += XM, Y0 += YM
    If ( RD )
        Xf += XM, Yf += YM
    If ( X0 < Xf )
        sX := X0-OfL, bX := Xf+OfR
    Else
        sX := Xf-OfL, bX := X0+OfR
    If ( Y0 < Yf )
        sY := Y0-OfT, bY := Yf+OfB
    Else
        sY := Yf-OfT, bY := Y0+OfB
    Loop, % (--N)-1 {
        Random, X%A_Index%, %sX%, %bX%
        Random, Y%A_Index%, %sY%, %bY%
    }
    X%N% := Xf, Y%N% := Yf, E := ( I := A_TickCount ) + Time
    While ( A_TickCount < E ) {
        U := 1 - (T := (A_TickCount-I)/Time)
        Loop, % N + 1 + (X := Y := 0) {
            Loop, % Idx := A_Index - (F1 := F2 := F3 := 1)
                F2 *= A_Index, F1 *= A_Index
            Loop, % D := N-Idx
                F3 *= A_Index, F1 *= A_Index+Idx
            M:=(F1/(F2*F3))*((T+0.000001)**Idx)*((U-0.000001)**D), X+=M*X%Idx%, Y+=M*Y%Idx%
        }
        MouseMove, %X%, %Y%, 0
        Sleep, 1
    }
    MouseMove, X%N%, Y%N%, 0
    Return N+1
}
Sleeptime(mintimer,maxtimer){ ;ok
	random, timer,mintimer,maxtimer
	Sleep timer
}

Gui, Add, Edit, x102 y19 w70 h20 vqtde, 1500
Gui, Add, Text, x12 y19 w80 h20 , Qtde Ores
Gui, Add, Text, x12 y59 w80 h20 vfsete cred , Ore x1y1(F7)
Gui, Add, Text, x12 y79 w80 h20 vfoito cred, Ore x2y2(F8)
Gui, Add, Text, x12 y99 w80 h20 vfnove cred , Ore x1y1(F9)
Gui, Add, Text, x12 y119 w80 h20 vfdez cred, Ore x2y2(F10)
Gui, Add, Text, x102 y59 w70 h20 vfonze cred, Ore x1y1(F11)
Gui, Add, Text, x102 y79 w70 h20 vfdoze cred, Ore x2y2(F12)
Gui, Add, Button, x102 y139 w70 h20 gstart , Start
Gui, Show, x1 y1 w203 h164, Mining Iron Ore
gui, +alwaysontop
return

F1::
xpmade:="00"
timerm := "00"
timers := "00"
gui,submit,nohide
gui,destroy
Gui,+AlwaysOnTop
Gui, Add, Text, x12 y9 w70 h30 , Total Ores Minerados:
Gui, Add, Text, x92 y19 w60 h20 voresminerados , %oresminerados%
Gui, Add, Text, x12 y49 w70 h30 , Tempo Em Execução:
Gui, Add, Text, x92 y59 w60 h20 vexectimer, %timerm%:%timers%
Gui, Add, Text, x12 y89 w70 h30 , Xp Base Feita:
Gui, Add, Text, x92 y89 w60 h40 vxpmade, %xpmade% xp.
Gui, Show, x1 y1 w163 h132, Untitled GUI

Settimer, Stopwatch, 1000

quantidade:=Floor(qtde/27)


Loop %quantidade% {
Loop 9{

random, 1orex, fnovex, fdezx
random, 1orey, fnovey, fdezy
random, 2orex, fonzex, fdozex
random, 2orey, fonzey, fdozey
random, 3orex, fsetex, foitox
random, 3orey, fsetey, foitoy

	mousegetpos, currentposx, currentposy
	RandomBezier(currentposx, currentposy, 1orex, 1orey, "T600 OT15 OB15 OL15 OR15" )
	sleeptime(100,150)
	Click

	sleeptime(800,1200)
	oresminerados++
	xpmade:=(xpmade+35)
	GuiControl, , oresminerados ,  %oresminerados% Ores.
	GuiControl, , xpmade ,  %xpmade% Xp.

	mousegetpos, currentposx, currentposy
	RandomBezier(currentposx, currentposy, 2orex, 2orey, "T600 OT15 OB15 OL15 OR15" )
	sleeptime(100,150)
	Click

	sleeptime(800,1200)
	oresminerados++
	xpmade:=(xpmade+35)
	GuiControl, , oresminerados ,  %oresminerados% Ores.
	GuiControl, , xpmade ,  %xpmade% Xp.

	mousegetpos, currentposx, currentposy
	RandomBezier(currentposx, currentposy, 3orex, 3orey, "T600 OT15 OB15 OL15 OR15" )
	sleeptime(100,150)
	Click

	sleeptime(800,1200)
	oresminerados++
	xpmade:=(xpmade+35)
	GuiControl, , oresminerados ,  %oresminerados% Ores.
	GuiControl, , xpmade ,  %xpmade% Xp.

			}

gosub, dropinv

}




F2::
Reload
GuiClose:
F3::
ExitApp
f7::
mousegetpos,fsetex, fsetey
;guicontrol, , foito, Done!
gui,font,cgreen
guicontrol,font,fsete
return
f8::
mousegetpos,foitox, foitoy
;guicontrol, , foito, Done!
gui,font,cgreen
guicontrol,font,foito
return
f9::
mousegetpos,fnovex, fnovey
;guicontrol, , fnove, Done!
gui,font,cgreen
guicontrol,font,fnove
return
f10::
mousegetpos,fdezx, fdezy
;guicontrol, , fdez, Done!
gui,font,cgreen
guicontrol,font,fdez
return
f11::
mousegetpos,fonzex, fonzey
;guicontrol, , fonze, Done!
gui,font,cgreen
guicontrol,font,fonze
return
f12::
mousegetpos,fdozex, fdozey
;guicontrol, , fdoze, Done!
gui,font,cgreen
guicontrol,font,fdoze
return

{ ;;start button function
start:
gui, submit, nohide
send {f1}
return
}


Stopwatch:
timers += 1
if(timers > 59)
{
	timerm += 1
	timers := "0"
	GuiControl, , exectimer ,  %timerm%:%timers%
}
if(timers < 10)
{
	GuiControl, , exectimer ,  %timerm%:0%timers%
}
else
{
	GuiControl, , exectimer ,  %timerm%:%timers%
}
return

dropinv:
Send {Shift Down}
gosub,randomvar
{ ;Slot 1
		mousegetpos, mousex, mousey
		RandomBezier(mousex, mousey, inv1x, inv1y, "T100 OT15 OB15 OL15 OR15")
		Click
		gosub, sleepdropinv
	}
{ ;Slot 2
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv2x, inv2y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
	}
{ ;Slot 3
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv3x, inv3y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 4
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv4x, inv4y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 8
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv8x, inv8y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 7
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv7x, inv7y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 6
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv6x, inv6y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 5
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv5x, inv5y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 9
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv9x, inv9y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 10
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv10x, inv10y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 11
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv11x, inv11y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 12
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv12x, inv12y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 16
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv16x, inv16y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 15
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv15x, inv15y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 14
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv14x, inv14y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 13
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv13x, inv13y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}

{ ;Slot 17
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv17x, inv17y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 18
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv18x, inv18y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 19
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv19x, inv19y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 20
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv20x, inv20y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 24
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv24x, inv24y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 23
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv23x, inv23y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 22
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv22x, inv22y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 21
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv21x, inv21y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}

{ ;Slot 25
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv25x, inv25y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 26
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv26x, inv26y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
{ ;Slot 27
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv27x, inv27y, "T100 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
/*{ ;Slot 28
	mousegetpos, mousex, mousey
	RandomBezier(mousex, mousey, inv28x, inv28y, "T300 OT15 OB15 OL15 OR15")
	Click
		gosub, sleepdropinv
}
*/
Send {Shift Up}
return

randomvar:
inv1x1:=1464
inv1x2:=1487
inv1y1:=750
inv1y2:=771
inv2x1:=1506
inv2x2:=1529
inv2y1:=750
inv2y2:=771
inv3x1:=1548
inv3x2:=1572
inv3y1:=750
inv3y2:=771
inv4x1:=1590
inv4x2:=1615
inv4y1:=750
inv4y2:=771
inv5x1:=1464
inv5x2:=1487
inv5y1:=785
inv5y2:=808
inv6x1:=1506
inv6x2:=1529
inv6y1:=785
inv6y2:=808
inv7x1:=1548
inv7x2:=1572
inv7y1:=785
inv7y2:=808
inv8x1:=1590
inv8x2:=1615
inv8y1:=785
inv8y2:=808
inv9x1:=1464
inv9x2:=1487
inv9y1:=823
inv9y2:=841
inv10x1:=1506
inv10x2:=1529
inv10y1:=823
inv10y2:=841
inv11x1:=1548
inv11x2:=1572
inv11y1:=823
inv11y2:=841
inv12x1:=1590
inv12x2:=1615
inv12y1:=823
inv12y2:=841
inv13x1:=1464
inv13x2:=1487
inv13y1:=858
inv13y2:=880
inv14x1:=1506
inv14x2:=1529
inv14y1:=858
inv14y2:=880
inv15x1:=1548
inv15x2:=1572
inv15y1:=858
inv15y2:=880
inv16x1:=1590
inv16x2:=1615
inv16y1:=858
inv16y2:=880
inv17x1:=1464
inv17x2:=1487
inv17y1:=893
inv17y2:=913
inv18x1:=1506
inv18x2:=1529
inv18y1:=893
inv18y2:=913
inv19x1:=1548
inv19x2:=1572
inv19y1:=893
inv19y2:=913
inv20x1:=1590
inv20x2:=1615
inv20y1:=893
inv20y2:=913
inv21x1:=1464
inv21x2:=1487
inv21y1:=930
inv21y2:=953
inv22x1:=1506
inv22x2:=1529
inv22y1:=930
inv22y2:=953
inv23x1:=1548
inv23x2:=1572
inv23y1:=930
inv23y2:=953
inv24x1:=1590
inv24x2:=1615
inv24y1:=930
inv24y2:=953
inv25x1:=1464
inv25x2:=1487
inv25y1:=966
inv25y2:=986
inv26x1:=1506
inv26x2:=1529
inv26y1:=966
inv26y2:=986
inv27x1:=1548
inv27x2:=1572
inv27y1:=966
inv27y2:=986
inv28x1:=1590
inv28x2:=1615
inv28y1:=966
inv28y2:=986

random, inv1x, inv1x1,inv1x2
random, inv1y, inv1y1,inv1y2
random, inv2x, inv2x1,inv2x2
random, inv2y, inv2y1,inv2y2
random, inv3x, inv3x1,inv3x2
random, inv3y, inv3y1,inv3y2
random, inv4x, inv4x1,inv4x2
random, inv4y, inv4y1,inv4y2
random, inv5x, inv5x1,inv5x2
random, inv5y, inv5y1,inv5y2
random, inv6x, inv6x1,inv6x2
random, inv6y, inv6y1,inv6y2
random, inv7x, inv7x1,inv7x2
random, inv7y, inv7y1,inv7y2
random, inv8x, inv8x1,inv8x2
random, inv8y, inv8y1,inv8y2
random, inv9x, inv9x1,inv9x2
random, inv9y, inv9y1,inv9y2
random, inv10x, inv10x1,inv10x2
random, inv10y, inv10y1,inv10y2
random, inv11x, inv11x1,inv11x2
random, inv11y, inv11y1,inv11y2
random, inv12x, inv12x1,inv12x2
random, inv12y, inv12y1,inv12y2
random, inv13x, inv13x1,inv13x2
random, inv13y, inv13y1,inv13y2
random, inv14x, inv14x1,inv14x2
random, inv14y, inv14y1,inv14y2
random, inv15x, inv15x1,inv15x2
random, inv15y, inv15y1,inv15y2
random, inv16x, inv16x1,inv16x2
random, inv16y, inv16y1,inv16y2
random, inv17x, inv17x1,inv17x2
random, inv17y, inv17y1,inv17y2
random, inv18x, inv18x1,inv18x2
random, inv18y, inv18y1,inv18y2
random, inv19x, inv19x1,inv19x2
random, inv19y, inv19y1,inv19y2
random, inv20x, inv20x1,inv20x2
random, inv20y, inv20y1,inv20y2
random, inv21x, inv21x1,inv21x2
random, inv21y, inv21y1,inv21y2
random, inv22x, inv22x1,inv22x2
random, inv22y, inv22y1,inv22y2
random, inv23x, inv23x1,inv23x2
random, inv23y, inv23y1,inv23y2
random, inv24x, inv24x1,inv24x2
random, inv24y, inv24y1,inv24y2
random, inv25x, inv25x1,inv25x2
random, inv25y, inv25y1,inv25y2
random, inv26x, inv26x1,inv26x2
random, inv26y, inv26y1,inv26y2
random, inv27x, inv27x1,inv27x2
random, inv27y, inv27y1,inv27y2
random, inv28x, inv28x1,inv28x2
random, inv28y, inv28y1,inv28y2

return

sleepdropinv:
sleeptime(30,80)
return