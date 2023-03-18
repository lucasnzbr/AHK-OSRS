#SingleInstance, force
coordmode, mouse, screen
coordmode, pixel, screen
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
Status(stastatusfunc){
			global Status:="%statusfunc%"
			GuiControl, , status ,  %stastatusfunc%
		}


;Scriptlist:="Swamp Lizard|"
Gui, Add, Button, x112 y159 w80 h20 , Start
;Gui, Add, DropDownList, x72 y9 w120 h200 ggetready vscript, % Scriptlist
;Gui, Add, Text, x22 y4 w50 h30 , Script Selection
Gui, Add, Text, x12 y49 w80 h20 cred vfcinco , Duelling 8(F5)
Gui, Add, Text, x12 y69 w80 h30 cred vfseis, Binding Neck(F6)
Gui, Add, Text, x12 y99 w90 h20 cred vfsete, Stamina Pot 1(F7)
Gui, Add, Text, x12 y119 w90 h20 cred vfoito, Earth Tally(F8)
gui, add, edit, x112 y49 w40 h20 vquantidade number limit3, 100
Gui, Add, Text, x152 y54 w50 h20, Runs
Gui, Add, Text, x112 y79 w80 h30 cred vfnove, Pure Ess(F9)
;Gui, Add, Text, x112 y109 w80 h30 cred vfdez, Relevant Item 2 Bank(F10)
Gui, Show, x5 y5 w205 h182, Hunter
gui, +alwaysontop
return


F1::
variacaotamanhoslot:= 12 ; alterar esse valor caso esteja numa resolução diferente de 1920 x 1080. Ele define a "abertura" do slot do inventario a partir do centro.
Settimer, Stopwatch, 1000
xpmade:="00"
segundosdesdeocomeco:="00"
timerm := "00"
timers := "00"
Counter :=0
itensfeitos:=0
status:="iniciando..."
gui,submit,nohide
gui,destroy
Gui,+AlwaysOnTop
Gui, Add, Text, x12 y9 w70 h30 , Total Runs Feitas:
Gui, Add, Text, x92 y19 w60 h20 vitensfeitos , %itensfeitos%
Gui, Add, Text, x12 y39 w70 h30 , Tempo Em Execução:
Gui, Add, Text, x92 y49 w60 h20 vexectimer, %timerm%:%timers%
Gui, Add, Text, x12 y79 w70 h30 , Xp Base Feita:
Gui, Add, Text, x92 y79 w65 h40 vxpmade, %xpmade% xp.
Gui, Add, text, x12 y99 w65 h40 cblue vstatus, %status%
Gui, Show, x1 y700 w163 h132, Hunter
maxtimer:=quantidade
counterbindingneck:=0
counterduellingestamina:=0
invcounterstarter:=0

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

msgbox, Começar em castle wars usando um dueling(8). Script criado com zoom 202. Fixed Stretched.

loop %quantidade%{
	Pixelsearch,bankx,banky,596,477,761,643,0xff00ff,3,fast ;se há bank e clica
status("Banking")
		If (errorlevel == 0){
			mousegetpos,mousex,mousey
			random,var1,5,15
			random,var2,5,15
			bankx+=var1
			banky+=var2
			RandomBezier(mousex, mousey,bankx,banky, "T300 OT15 OB15 OL15 OR15")
			Sleeptime(200,350)
			Click
			sleeptime(4000,5000)

			mousegetpos,mousex,mousey
			random,slot2x,1314,1348
			random,slot2y,475,500
			RandomBezier(mousex, mousey,slot2x,slot2y, "T300 OT15 OB15 OL15 OR15")
			Sleeptime(150,300)
			Click
			sleeptime(150,30)
		}
		If (errorlevel == 1){
			msgbox, bank não encontrado
		}
	If (counterduellingestamina == 4){
		status("Stamina Pot")
		Gosub, DrinkStamina
		status("Duelling Ring")
		Gosub, GetDuellingRing
		counterduellingestamina:=0
	}
		If (counterbindingneck == 16){
		status("Binding Neck")
		Gosub, GetBindingNeck
		counterbindingneck:=0
	}
	counterduellingestamina++
	counterbindingneck++
	status("Earth Talisman")
	Gosub,GetEarthTally
	status("Pure Essence")
	Gosub,GetEss

	Sleeptime(200,300)
	send {esc}
	Sleeptime(200,300)

If (invcounterstarter == 0){
	status("Telando Duel Arena")
	mousegetpos,mousex,mousey
	random,worninventoryx,1426,1474
	random,worninventoryy,371,422
	RandomBezier(mousex, mousey,worninventoryx,worninventoryy, "T300 OT15 OB15 OL15 OR15")
	sleeptime(250,400)
	Click
	sleeptime(200,350)
	invcounterstarter++
	}
	mousegetpos,mousex,mousey
	random,ringslotx,1473,1524
	random,ringsloty,775,830
	send {shift down}
	RandomBezier(mousex, mousey,ringslotx,ringsloty, "T300 OT15 OB15 OL15 OR15")
	sleeptime(400,800)
	Click
	Sleeptime(200,500)
	send {shift up}

	Sleeptime(2500,3500)

	Pixelsearch,midtilex,midtiley,230,30,420,200,0xff0000,3,fast ;se há midterm tile
	status("Clicando Spot")
		If (errorlevel == 0){
			mousegetpos,mousex,mousey
			random,var1,5,32
			random,var2,5,32
			midtilex+=var1
			midtiley+=var2
			RandomBezier(mousex,mousey,midtilex,midtiley, "T300 OT15 OB15 OL15 OR15")
			Sleeptime(200,350)
			Click
			sleeptime(6000,7000)
		}
		If (errorlevel == 1){
			msgbox, Mid Tile não encontrado
		}


		mousegetpos,mousex,mousey
		random,ruinsx,730,768
		random,ruinsy,44,90
		status("Clicando Ruinas")
		RandomBezier(mousex,mousey,ruinsx,ruinsy, "T300 OT15 OB15 OL15 OR15")
		Sleeptime(300,600)
		Click
		Sleeptime(500,800)

		mousegetpos,mousex,mousey
		random,inventoryx,1353,1400
		random,inventoryy,372,418
		RandomBezier(mousex, mousey,inventoryx,inventoryy, "T300 OT15 OB15 OL15 OR15")
		sleeptime(200,450)
		Click
		sleeptime(200,450)
		mousegetpos,mousex,mousey
		random,slot1x,1225,1260
		random,slot1y,473,503
		RandomBezier(mousex, mousey,slot1x,slot1y, "T300 OT15 OB15 OL15 OR15")
		sleeptime(220,350)
		Click
		sleeptime(220,350)
		mousegetpos,mousex,mousey
		random,altarx,837,903
		random,altary,676,703
		RandomBezier(mousex, mousey,altarx,altary, "T300 OT15 OB15 OL15 OR15")
		status("Clicando Altar")
		sleeptime(800,1200)
		Click
		sleeptime(4200,5800)
		xpmade+=273
		GuiControl, , xpmade ,  %xpmade% Xp.

	mousegetpos,mousex,mousey
	random,worninventoryx,1426,1474
	random,worninventoryy,371,422
	RandomBezier(mousex, mousey,worninventoryx,worninventoryy, "T300 OT15 OB15 OL15 OR15")
	status("Telando Castle Wars")
	sleeptime(300,550)
	Click
	sleeptime(300,550)
	mousegetpos,mousex,mousey
	random,ringslotx,1473,1524
	random,ringsloty,775,825
	RandomBezier(mousex, mousey,ringslotx,ringsloty, "T300 OT15 OB15 OL15 OR15")
	Sleeptime(350,600)
	Click
	Sleeptime(3700,4700)
	itensfeitos++
	GuiControl, , itensfeitos ,  %itensfeitos% Runs.
}

msgbox, Script Finalizado. %itensfeitos% Runs. Garantindo %xpmade% xp.


	/* PRIORIDADES:
bank
deposit lava
Take ring every 4 trips - binding neck every 16 - stamina every 4 trips
take 1 earth tally
take pures
esc
click equipment > shift ring
mysterious ruins
inv > earth rune > altar
equiped > castle wars

SHORTCUTS
Ring
Binding Neck
Stamina Pot(1)
Earth Tally
Pure Essence

*//*

	comeco:
Loop{
	status("Aguardando Trigger")
	Pixelsearch,swampx,swampy,1189,450,1570,952,0x095409,3,fast ;se há itens no inv
	If (errorlevel == 0){
		status("Dropando Inv")
		mousegetpos,mousex,mousey
		RandomBezier(mousex, mousey, swampx,swampy, "T300 OT15 OB15 OL15 OR15")
		sleeptime(130,180)
		Click
		sleeptime(130,180)
		}
		If (errorlevel == 1){
		Pixelsearch,itemchaox,itemchaoy,50,41,1088,684,0xcd0089,5,fast ;se ha itens no chao
			If (errorlevel == 0){
				status("Catando Item do Chao")
				mousegetpos,mousex,mousey
				random,var1,15,20
				random,var2,15,20
				itemchaox+=var1
				itemchaoy+=var2
				RandomBezier(mousex, mousey,itemchaox,itemchaoy, "T300 OT15 OB15 OL15 OR15")
				sleeptime(130,180)
				Click
				sleeptime(4000,5000)
				}
			If (errorlevel == 1){
				Pixelsearch,armadilhasprontasx,armadilhasprontasy,50,41,1088,684,0x00FFFF,15,fast ;achando armadilhas catched
					If (errorlevel == 0){
					status("Checando Armadilha Amarela")
					mousegetpos,mousex,mousey
					random,var1,15,20
					random,var2,15,20
					armadilhasprontasx+=var1
					armadilhasprontasy+=var2
					RandomBezier(mousex, mousey, armadilhasprontasx,armadilhasprontasy, "T300 OT15 OB15 OL15 OR15")
					sleeptime(130,180)
					Click
					sleeptime(3500,4800)
					itensfeitos++
					xpmade+=152
					GuiControl, , itensfeitos ,  %itensfeitos% catches.
					GuiControl, , xpmade ,  %xpmade% Xp.
					}
					If (errorlevel == 1){
						Pixelsearch,armadilhasemvermelhox,armadilhasemvermelhoy,50,41,1088,684,0x0000ff,3,fast ;achando armadilhas em vermelho
							If (errorlevel == 0){
							status("Armadilha Vermelha")
							loop 8{
							Pixelsearch,itemchaox,itemchaoy,50,41,1088,684,0xcd0089,5,fast ;acha itens em roxo ate acabarem
								If (errorlevel == 0){
								status("Item Do Chao, Armadilha Vermelha")
								mousegetpos,mousex,mousey
								random,var1,15,20
								random,var2,15,20
								itemchaox+=var1
								itemchaoy+=var2
								RandomBezier(mousex, mousey,itemchaox,itemchaoy, "T300 OT15 OB15 OL15 OR15")
								sleeptime(130,180)
								Click
								sleeptime(4000,5000)
								}
								If (errorlevel == 1){
									Pixelsearch,armadilhasemvermelhox,armadilhasemvermelhoy,50,41,1088,684,0x0000ff,3,fast ;achando armadilhas em vermelho
										If (errorlevel == 0){
											status("Armadilha Vermelha dps de dropar")
											mousegetpos,mousex,mousey
											random,var1,5,15
											random,var2,5,15
											armadilhasemvermelhox+=var1
											armadilhasemvermelhoy+=var2
											RandomBezier(mousex, mousey, armadilhasemvermelhox,armadilhasemvermelhoy, "T300 OT15 OB15 OL15 OR15")
											sleeptime(130,180)
											Click
											sleeptime(5000,7000)
											}
											If (errorlevel == 1){
											goto,comeco
											}
								}
							}
					}
				}
			}
		}
		If (segundosdesdeocomeco >= maxtimer){
		gosub, finalizar
}




									}

	}



finalizar:
msgbox, Script Finalizado. Capturadas %itensfeitos%. Garantindo %xpmade% xp.
*/
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
segundosdesdeocomeco++
return

}
GetDuellingRing:
	mousegetpos,mousex,mousey
	random,varx,-10,10
	random,vary,-10,10
	duelx:=fcincox
	duely:=fcincoy
	duelx+=varx
	duely+=vary
	RandomBezier(mousex,mousey,duelx,duely, "T300 OT15 OB15 OL15 OR15")
	sleeptime(400,700)
	Click
	sleeptime(300,800)

	mousegetpos,mousex,mousey
	random,slot2x,1314,1348
	random,slot2y,475,500
	RandomBezier(mousex, mousey,slot2x,slot2y, "T300 OT15 OB15 OL15 OR15")
	Sleeptime(200,350)
	Click
	sleeptime(300,600)
return
GetBindingNeck:
	mousegetpos,mousex,mousey
	random,varx,-10,10
	random,vary,-10,10
	bindingx:=fseisx
	bindingy:=fseisy
	bindingx+=varx
	bindingy+=vary
	RandomBezier(mousex,mousey,bindingx,bindingy, "T300 OT15 OB15 OL15 OR15")
	sleeptime(1000,1700)
	Click
	sleeptime(1300,1800)

	mousegetpos,mousex,mousey
	random,slot2x,1314,1348
	random,slot2y,475,500
	RandomBezier(mousex, mousey,slot2x,slot2y, "T300 OT15 OB15 OL15 OR15")
	Sleeptime(1200,1350)
	Click
	sleeptime(1400,1600)

return
DrinkStamina:
	mousegetpos,mousex,mousey
	random,varx,-10,10
	random,vary,-10,10
	staminax:=fsetex
	staminay:=fsetey
	staminax+=varx
	staminay+=vary
	RandomBezier(mousex,mousey,staminax,staminay, "T300 OT15 OB15 OL15 OR15")
	sleeptime(400,700)
	Click
	sleeptime(300,800)

	mousegetpos,mousex,mousey
	random,slot2x,1314,1348
	random,slot2y,475,500
	RandomBezier(mousex, mousey,slot2x,slot2y, "T300 OT15 OB15 OL15 OR15")
	Sleeptime(200,350)
	Click
	sleeptime(350,600)
return
GetEarthTally:
	mousegetpos,mousex,mousey
	random,varx,-10,10
	random,vary,-10,10
	tallyx:=foitox
	tallyy:=foitoy
	tallyx+=varx
	tallyy+=vary
	RandomBezier(mousex,mousey,tallyx,tallyy, "T300 OT15 OB15 OL15 OR15")
	sleeptime(250,600)
	Click
	sleeptime(300,500)
return
GetEss:
	mousegetpos,mousex,mousey
	random,varx,-10,10
	random,vary,-10,10
	essx:=fnovex
	essy:=fnovey
	essx+=varx
	essy+=vary
	RandomBezier(mousex,mousey,essx,essy, "T300 OT15 OB15 OL15 OR15")
	sleeptime(250,600)
	Click
	sleeptime(300,500)
return
