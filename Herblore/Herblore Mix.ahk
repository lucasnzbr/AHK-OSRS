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
Scriptlist:="Pots 14 em 14|"
Gui, Add, Button, x112 y159 w80 h20 , Start
Gui, Add, DropDownList, x72 y9 w120 h200 ggetready vscript, % Scriptlist
Gui, Add, Text, x22 y4 w50 h30 , Script Selection
Gui, Add, Text, x12 y49 w80 h20 cred vfcinco , Banker x1y1(F5)
Gui, Add, Text, x12 y69 w80 h20 cred vfseis, Banker x2y2(F6)
Gui, Add, Text, x12 y99 w90 h20 cred vfsete, Slot 1 Center(F7)
Gui, Add, Text, x12 y119 w90 h20 cred vfoito, Slot 28 Center(F8)
gui, add, edit, x112 y49 w40 h20 vquantidade number limit5, 99999
Gui, Add, Text, x152 y54 w50 h20, Unidades
Gui, Add, Text, x112 y79 w80 h30 cred vfnove, Relevant Item 1 Bank(F9)
Gui, Add, Text, x112 y109 w80 h30 cred vfdez, Relevant Item 2 Bank(F10)
Gui, Show, x5 y5 w205 h182, Crafting
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


If (script == "Pots 14 em 14") {
	Quantidadedeloopsaseremfeitosscriptpot14em14:=Ceil(quantidade/14)

	Loop %Quantidadedeloopsaseremfeitosscriptpot14em14% {

	mousegetpos,currentposx, currentposy
	random, bankx, fcincox,fseisx
	random, banky, fcincoy,fseisy
	RandomBezier(currentposx, currentposy, bankx, banky, "T600 OT15 OB15 OL15 OR15" ) ;mouse to bank
	sleeptime(100,300)
	Click
	Sleeptime(1000,1750)

	mousegetpos,currentposx, currentposy
	random, depositallx, 882,909 ;ALTERAR!!!!!!!
	random, depositally, 812,839 ;ALTERAR!!!!!!!
	RandomBezier(currentposx, currentposy, depositallx, depositally, "T600 OT15 OB15 OL15 OR15" ) ;click deposit all
	Sleeptime(500,800)
	Click
	sleeptime(800,1200)

	mousegetpos,currentposx, currentposy
		random,var,-10,10
		random,var2,-10,10
		fnovex:=fnovex+var
		fnovey:=fnovey+var2
	RandomBezier(currentposx, currentposy, fnovex, fnovey, "T600 OT15 OB15 OL15 OR15" ) ;click item bank, relevant item1
		fnovex:=fnovex-var
		fnovey:=fnovey-var2
	Sleeptime(500,800)
	Click
	Sleeptime(700,1100)

	mousegetpos,currentposx, currentposy
		random,var,-10,10
		random,var2,-10,10
		fdezx:=fdezx+var
		fdezy:=fdezy+var2
	RandomBezier(currentposx, currentposy, fdezx, fdezy, "T600 OT15 OB15 OL15 OR15" ) ;click item bank, relevant item2
		fdezx:=fdezx-var
		fdezy:=fdezy-var2
	Sleeptime(500,800)
	Click
	Sleeptime(700,1100)

	send {esc}

	mousegetpos,currentposx, currentposy
		random,var,-10,10
		random,var2,-10,10
		coluna2:=coluna2+var
		linha4:=linha4+var2
	RandomBezier(currentposx, currentposy, coluna2, linha4, "T600 OT15 OB15 OL15 OR15" ) ;click slot1
		coluna2:=coluna2-var
		linha4:=linha4-var2
	Sleeptime(1000,1400)
	Click
	Sleeptime(400,750)

	mousegetpos,currentposx, currentposy
		random,var,-10,10
		random,var2,-10,10
		coluna3:=coluna3+var
		linha4:=linha4+var2
	RandomBezier(currentposx, currentposy, coluna3, linha4, "T400 OT15 OB15 OL15 OR15" ) ;click slot2
		coluna3:=coluna3-var
		linha4:=linha4-var2
	Sleeptime(400,750)
	Click
	Sleeptime(1500,2100)

	Send {space}
	random,sleeptimer,17500,21500
	sleeptimer2:=(sleeptimer/14)
	loop 14{
		sleep sleeptimer2
		itensfeitos++
        GuiControl, , itensfeitos , %itensfeitos%.
		xpmade:=(xpmade+84)
        GuiControl, , xpmade , %xpmade% xp.
	}

	}
	msgbox, Script Finalizado. Feitos %itensfeitos% Pots. Garantindo %xpmade% xp.

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
