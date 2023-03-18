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


Gui, Add, Edit, x102 y19 w70 h20 vminutes, 180
Gui, Add, Text, x12 y19 w80 h40 , Quantos minutos?
Gui, Add, Text, x12 y59 w80 h40 vfcinco cred , Spot Aggro1 x1y1(F5)
Gui, Add, Text, x12 y89 w80 h40 vfseis cred, Spot Aggro1 x2y2(F6)
Gui, Add, Text, x12 y119 w80 h40 vfsete cred, Spot Aggro2 x1y1(F7)
Gui, Add, Text, x12 y149 w80 h40 vfoito cred, Spot Aggro2 x2y2(F8)
Gui, Add, Text, x102 y59 w80 h40 vfnove cred , Spot Train1 x1y1(F9)
Gui, Add, Text, x102 y89 w80 h40 vfdez cred, Spot Train1 x2y2(F10)
Gui, Add, Text, x102 y119 w80 h40 vfonze cred , Spot Train2 x1y1(F11)
Gui, Add, Text, x102 y149 w80 h40 vfdoze cred, Spot Train2 x2y2(F12)
Gui, Add, Text, x132 y179 w80 h40 cblue, Start(F1)
Gui, Show, x1 y1 w203 h200, Sand Crabs
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
Gui, Show, x1 y1 w163 h52, Untitled GUI
Settimer, Stopwatch, 1000
quantidade:=Floor(minutes/20)

Loop %quantidade% {
{ ;1 loop
;andar pra lado1
Mousegetpos,mousex,mousey
random,aggro1x,fcincox,fseisx
random,aggro1y,fcincoy,fseisy
RandomBezier(mousex, mousey, aggro1x, aggro1y, "T450 OT15 OB15 OL15 OR15")
sleeptime(300,600)
click
sleeptime(9000,14000) ;ate chegar

;voltar
Mousegetpos,mousex,mousey
random,voltar1x,fnovex,fdezx
random,voltar1y,fnovey,fdezy
RandomBezier(mousex, mousey, voltar1x, voltar1y, "T450 OT15 OB15 OL15 OR15")
sleeptime(300,600)
click

;sleep do timer
sleeptime(600000,635000)
}
{ ;2 loop

;andar pra lado2
Mousegetpos,mousex,mousey
random,aggro2x,fsetex,foitox
random,aggro2y,fsetey,foitoy
RandomBezier(mousex, mousey, aggro2x, aggro2y, "T450 OT15 OB15 OL15 OR15")
sleeptime(300,600)
click
sleeptime(9000,14000) ;ate chegar

;voltar
Mousegetpos,mousex,mousey
random,voltar2x,fonzex,fdozex
random,voltar2y,fonzey,fdozey
RandomBezier(mousex, mousey, voltar2x, voltar2y, "T450 OT15 OB15 OL15 OR15")
sleeptime(300,600)
click

;sleep do timer
sleeptime(600000,635000)
}
}
msgbox, You ran the script for %timerm% minutes.

F2::
Reload
GuiClose:
F3::
ExitApp
f5::
mousegetpos,fcincox, fcincoy
;guicontrol, , foito, Done!
gui,font,cgreen
guicontrol,font,fcinco
return
f6::
mousegetpos,fseisx, fseisy
;guicontrol, , foito, Done!
gui,font,cgreen
guicontrol,font,fseis
return
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

