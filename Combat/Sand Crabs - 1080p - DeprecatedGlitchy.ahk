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
Sleepfor(mintimer,maxtimer){ ;ok
	random, timer,mintimer,maxtimer
	Sleep timer
}


Gui, Add, Edit, x102 y19 w70 h20 vminutes, 180
Gui, Add, Text, x12 y19 w80 h40 , Quantos minutos?
Gui, Add, Text, x12 y59 w80 h40 vfnove cred , Spot Aggro x1y1(F9)
Gui, Add, Text, x12 y89 w80 h40 vfdez cred, Spot Aggro x2y2(F10)
Gui, Add, Text, x102 y59 w70 h40 vfonze cred, Spot Train x1y1(F11)
Gui, Add, Text, x102 y89 w70 h40 vfdoze cred, Spot Train x2y2(F12)
Gui, Add, Button, x122 y139 w50 h20 gstart , Start
Gui, Add, text, x12 y119 w100 h60 cblue gstart , Spot Aggro (Pisar no Spot Train)               Spot Train (Pisar Spot Aggro)
Gui, Show, x1 y200 w203 h175, Sand Crabs
gui, +alwaysontop
return

F1::
timerm := "00"
timers := "00"
gui,submit,nohide
gui,destroy
Gui,+AlwaysOnTop
Gui, Add, Text, x12 y9 w70 h30 , Tempo Em Execução:
Gui, Add, Text, x92 y19 w60 h20 vexectimer, %timerm%:%timers%
Gui, Show, x1 y220 w163 h52, Untitled GUI
Settimer, Stopwatch, 1000
quantidade:=Floor(minutes/10)

Loop %quantidade% {
    random,sleeep,650000,675000
    sleep sleeep
{ ;walkaway
Random, aggrox, fnovex, fdezx
Random, aggroy, fnovey, fdezy
mousegetpos,mousex, mousey
RandomBezier(mousex, mousey, aggrox, aggroy, "T450 OT15 OB15 OL15 OR15")
sleeptime(500,800)
Click
}

	random, timer,13000,21000
	Sleep timer

{ ;camerasouth
random,camerax,1474,1494
random,cameray,37,53
random,cameravarx,-35,15
random,cameravary,53,60
mousegetpos,mousex,mousey
RandomBezier(mousex, mousey, camerax, cameray, "T400 OT15 OB15 OL15 OR15")
sleeptime(200,400)
Click,Right
sleeptime(1000,1700)
mousegetpos,mousex,mousey
newmouseposx:=(mousex+cameravarx)
newmouseposy:=(mousey+cameravary)
RandomBezier(mousex, mousey, newmouseposx, newmouseposy, "T400 OT15 OB15 OL15 OR15")
sleeptime(200,350)
Click
send {up down}
sleeptime(3000,4500)
send {up up}
}
	random, timer,500,800
	Sleep timer
{ ;walkback
Random, trainx, fonzex, fdozex
Random, trainy, fonzey, fdozey
RandomBezier(mousex, mousey, trainx, trainy, "T450 OT15 OB15 OL15 OR15")
Sleeptime(500,800)
Click
}
	random, timer,20000,28000
	Sleep timer
{ ;camera north
random,camerax,1474,1494
random,cameray,37,53
mousegetpos,mousex,mousey
RandomBezier(mousex, mousey, camerax, cameray, "T400 OT15 OB15 OL15 OR15")
sleeptime(200,400)
Click
sleeptime(500,800)
send {up down}
sleeptime(3000,4500)
send {up up}
}

}

msgbox, You ran the script for %timerm% minutes.

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

