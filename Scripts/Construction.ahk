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

Scriptlist:="Construct Oak Larders|"
Gui, Add, Button, x112 y159 w80 h20 , Start
Gui, Add, DropDownList, x72 y9 w120 h200 ggetready vscript, % Scriptlist
Gui, Add, Text, x22 y4 w50 h30 , Script Selection
Gui, Add, Text, x12 y40 w80 h20 cred vfquatro , Planks Bank(F4)
Gui, Add, Text, x12 y74 w80 h20 cred vfcinco , Bank x1y1(F5)
Gui, Add, Text, x12 y89 w80 h20 cred vfseis, Bank x2y2(F6)
Gui, Add, Text, x12 y104 w90 h20 cred vfsete, Larder1 x1y1(F7)
Gui, Add, Text, x12 y119 w90 h20 cred vfoito, Larder1 x2y2(F8)
Gui, Add, Text, x112 y74 w80 h30 cred vfnove, Larder2 x1y1(F9)
Gui, Add, Text, x112 y89 w100 h30 cred vfdez, Larder2 x2y2(F10)
Gui, Add, Text, x112 y104 w100 h30 cred vfonze, Teleport x1x1(F11)
Gui, Add, Text, x112 y119 w100 h30 cred vfdoze, Teleport x2y2(F12)
gui, add, edit, x112 y49 w40 h20 vquantidade number limit5, 500
Gui, Add, Text, x152 y54 w50 h20, Planks
Gui, Add, Text, x29 y139 w60 h40 cblue, TELETAB SLOT4!!!!!

Gui, Show, x5 y5 w205 h182, Construction
gui, +alwaysontop
return


F1::
variacaotamanhoslot:= 12 ; alterar esse valor caso esteja numa resolução diferente de 1920 x 1080. Ele define a "abertura" do slot do inventario a partir do centro.
Settimer, Stopwatch, 1000
xpmade:="00"
timerm := "00"
timers := "00"
Counter :=0
itensfeitos:=0
gui,submit,nohide
gui,destroy
Gui,+AlwaysOnTop
Gui, Add, Text, x12 y9 w70 h30 , Total Itens Feitos:
Gui, Add, Text, x92 y19 w60 h20 vitensfeitos , %itensfeitos%
Gui, Add, Text, x12 y49 w70 h30 , Tempo Em Execução:
Gui, Add, Text, x92 y59 w60 h20 vexectimer, %timerm%:%timers%
Gui, Add, Text, x12 y89 w70 h30 , Xp Base Feita:
Gui, Add, Text, x92 y89 w65 h40 vxpmade, %xpmade% xp.
Gui, Show, x1 y1 w163 h132, Untitled GUI

x := ((foitox-fsetex)/3)
y := ((foitoy-fsetey)/6)
coluna1:=fsetex
coluna2:=(fsetex+x)
coluna3:=(fsetex+2*x)
coluna4:=(fsetex+3*x)
linha1:= fsetey
linha2:=(fsetey+y)
linha3:=(fsetey+2*y)
linha4:=(fsetey+3*y)
linha5:=(fsetey+4*y)
linha6:=(fsetey+5*y)
linha7:=(fsetey+6*y)


If (script == "Construct Oak Larders") {
	Quantidadedeloopsaseremfeitosscriptlarders:=Ceil(quantidade/24)

	Loop %Quantidadedeloopsaseremfeitosscriptlarders% {

	mousegetpos,currentposx, currentposy
	random, bankx, fcincox,fseisx
	random, banky, fcincoy,fseisy
	RandomBezier(currentposx, currentposy, bankx, banky, "T600 OT15 OB15 OL15 OR15" ) ;mouse to bank
	sleeptime(100,300)
	Click
	Sleeptime(6000,8000)

	mousegetpos,currentposx, currentposy
	random, var1, -8,8
	random, var2, -8,8
	fquatrox:=fquatrox+var1
	fquatroy:=fquatroy+var2
	RandomBezier(currentposx, currentposy, fquatrox, fquatroy, "T600 OT15 OB15 OL15 OR15" ) ;mouse to item inside bank
	fquatrox:=fquatrox-var1
	fquatroy:=fquatroy-var2
	sleeptime(100,300)
	Click
	Sleeptime(1200,1800)

	send {esc}
	Sleeptime(1000,1600)

	mousegetpos,currentposx, currentposy
	random, teletabx, 1592,1613
	random, teletaby, 748,769
	RandomBezier(currentposx, currentposy, teletabx, teletaby, "T600 OT15 OB15 OL15 OR15" ) ;mouse to teletab
	sleeptime(100,300)
	Click
	Sleeptime(6000,6800)

	mousegetpos,currentposx, currentposy
	random, larder1x, fsetex,foitox
	random, larder1y, fsetey,foitoy
	RandomBezier(currentposx, currentposy, larder1x, larder1y, "T600 OT15 OB15 OL15 OR15" ) ;mouse to larder
	sleeptime(500,900)
	click,Right
	mousegetpos,mousex,mousey
	random,variaveldex,-60,60
	random,variaveldey,50,61
	mousexdestino:=mousex+variaveldex
	mouseydestino:=mousey+variaveldey
	random,destinolarderx1,
	RandomBezier(mousex, mousey, mousexdestino, mouseydestino, "T600 OT15 OB15 OL15 OR15" ) ;mouse to larder to go put first
	sleeptime(500,900)
	click
	sleeptime(3500,4200)
		send 2
	sleeptime(2000,2600)
				itensfeitos++
				GuiControl, , itensfeitos , %itensfeitos%.
				xpmade:=(xpmade+480)
				GuiControl, , xpmade , %xpmade% xp.

	mousegetpos,currentposx, currentposy
	random, larder2x, fnovex,fdezx
	random, larder2y, fnovey,fdezy
	RandomBezier(currentposx, currentposy, larder2x, larder2y, "T600 OT15 OB15 OL15 OR15" ) ;mouse to larder
	sleeptime(100,300)
	click,Right
	mousegetpos,mousex,mousey
	random,variaveldex,-45,45
	random,variaveldey,66,75
	mousexdestino:=mousex+variaveldex
	mouseydestino:=mousey+variaveldey
	random,destinolarderx1,
	RandomBezier(mousex, mousey, mousexdestino, mouseydestino, "T600 OT15 OB15 OL15 OR15" ) ;mouse to larder to remove first
	sleeptime(100,300)
	click
	sleeptime(2000,2500)
	send 1
	sleeptime(2000,2600)

loop 2{
	mousegetpos,currentposx, currentposy
	random, larder2x, fnovex,fdezx
	random, larder2y, fnovey,fdezy
	RandomBezier(currentposx, currentposy, larder2x, larder2y, "T600 OT15 OB15 OL15 OR15" ) ;mouse to larder
	sleeptime(100,300)
	click,Right
	mousegetpos,mousex,mousey
	random,variaveldex,-45,45
	random,variaveldey,50,60
	mousexdestino:=mousex+variaveldex
	mouseydestino:=mousey+variaveldey
	random,destinolarderx1,
	RandomBezier(mousex, mousey, mousexdestino, mouseydestino, "T600 OT15 OB15 OL15 OR15" ) ;mouse to larder to put second
	sleeptime(100,300)
	click
	sleeptime(2000,2500)
	send 2
	sleeptime(2000,2600)
				itensfeitos++
				GuiControl, , itensfeitos , %itensfeitos%.
				xpmade:=(xpmade+480)
				GuiControl, , xpmade , %xpmade% xp.

	mousegetpos,currentposx, currentposy
	random, larder2x, fnovex,fdezx
	random, larder2y, fnovey,fdezy
	RandomBezier(currentposx, currentposy, larder2x, larder2y, "T600 OT15 OB15 OL15 OR15" ) ;mouse to larder
	sleeptime(100,300)
	click,Right
	mousegetpos,mousex,mousey
	random,variaveldex,-45,45
	random,variaveldey,66,75
	mousexdestino:=mousex+variaveldex
	mouseydestino:=mousey+variaveldey
	random,destinolarderx1,
	RandomBezier(mousex, mousey, mousexdestino, mouseydestino, "T600 OT15 OB15 OL15 OR15" ) ;mouse to larder to remove second and third
	sleeptime(100,300)
	click
	sleeptime(2000,2500)
	send 1
	sleeptime(2000,2600)
}

	mousegetpos,currentposx, currentposy
	random, teleoutx, fonzex,fdozex
	random, teleouty, fonzey,fdozey
	RandomBezier(currentposx, currentposy, teleoutx, teleouty, "T600 OT15 OB15 OL15 OR15" ) ;mouse to tele out
	sleeptime(100,300)
	Click
	Sleeptime(6000,7500)

	}
	msgbox, Script Finalizado. Feitos %itensfeitos% no glassblowing pipe. Garantindo %xpmade% xp.
}

F2::
Reload
GuiClose:
F3::
ExitApp

{ ;;Funções Label F5 a F12 e outras
getready:
Gui, submit, NoHide
return
f4::
mousegetpos,fquatrox, fquatroy
;guicontrol, , foito, Done!
gui,font,cgreen
guicontrol,font,fquatro
return
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
start: ;;start button function
gui, submit, nohide
send {f1}
return
Stopwatch: ;;Relógio
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
}
bugvar:
random,var, -variacaotamanhoslot,variacaotamanhoslot
coluna1:=coluna1+var
coluna2:=coluna2+var
coluna3:=coluna3+var
coluna4:=coluna4+var
linha1:=linha1+var
linha2:=linha2+var
linha3:=linha3+var
linha4:=linha4+var
linha5:=linha5+var
linha6:=linha6+var
linha7:=linha7+var
fnove:=fnove+var
fdez:=fdez+var
return
debugvar:
coluna1:=coluna1-var
coluna2:=coluna2-var
coluna3:=coluna3-var
coluna4:=coluna4-var
linha1:=linha1-var
linha2:=linha2-var
linha3:=linha3-var
linha4:=linha4-var
linha5:=linha5-var
linha6:=linha6-var
linha7:=linha7-var
fnove:=fnove-var
fdez:=fdez-var
return
