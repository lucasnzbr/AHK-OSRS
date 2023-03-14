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
Scriptlist:="Swamp Lizard|"
Gui, Add, Button, x112 y159 w80 h20 , Start
Gui, Add, DropDownList, x72 y9 w120 h200 ggetready vscript, % Scriptlist
Gui, Add, Text, x22 y4 w50 h30 , Script Selection
;Gui, Add, Text, x12 y49 w80 h20 cred vfcinco , Banker x1y1(F5)
;Gui, Add, Text, x12 y69 w80 h20 cred vfseis, Banker x2y2(F6)
;Gui, Add, Text, x12 y99 w90 h20 cred vfsete, Slot 1 Center(F7)
;Gui, Add, Text, x12 y119 w90 h20 cred vfoito, Slot 28 Center(F8)
gui, add, edit, x112 y49 w40 h20 vquantidade number limit5, 3000
Gui, Add, Text, x152 y54 w50 h20, Segundos
;Gui, Add, Text, x112 y79 w80 h30 cred vfnove, Relevant Item 1 Bank(F9)
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
Gui, Add, Text, x12 y9 w70 h30 , Total Itens Feitos:
Gui, Add, Text, x92 y19 w60 h20 vitensfeitos , %itensfeitos%
Gui, Add, Text, x12 y39 w70 h30 , Tempo Em Execução:
Gui, Add, Text, x92 y49 w60 h20 vexectimer, %timerm%:%timers%
Gui, Add, Text, x12 y79 w70 h30 , Xp Base Feita:
Gui, Add, Text, x92 y79 w65 h40 vxpmade, %xpmade% xp.
Gui, Add, text, x12 y99 w65 h40 cblue vstatus, %status%
Gui, Show, x1 y200 w163 h132, Hunter
maxtimer:=quantidade

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


If (script == "Swamp Lizard") {

	/* PRIORIDADES:
	 - Drop Inventario (trigger slot 28) C
	 - Itens no chao (roxo) C
	 - Armadilhas Prontas (verde)
	 - Armadilhas para serem postas (vermelho)
	*/
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
