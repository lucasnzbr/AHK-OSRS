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
Clicktinderbox(){
	mousegetpos,mousex,mousey
	tinderboxx:=1241
	tinderboxy:=486
	random,varx,-20,20
	random,vary,-20,20
	tinderboxx+=varx
	tinderboxy+=vary
	RandomBezier(mousex, mousey,tinderboxx,tinderboxy, "T300 OT15 OB15 OL15 OR15")
	sleeptime(200,400)
	Click
}


;Scriptlist:="Swamp Lizard|"
Gui, Add, Button, x112 y159 w80 h20 , Start
;Gui, Add, DropDownList, x72 y9 w120 h200 ggetready vscript, % Scriptlist
;Gui, Add, Text, x22 y4 w50 h30 , Script Selection
Gui, Add, Text, x12 y49 w80 h20 cred vfcinco , Madeira(F5)
Gui, Add, Text, x12 y69 w80 h30 cred vfseis, Binding Neck(F6)
Gui, Add, Text, x12 y99 w90 h20 cred vfsete, (F7)
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

firstinvx:=1239
firstinvy:=487
lastinvx:=1513
lastinvy:=924
x := ((lastinvx-firstinvx)/3)
y := ((lastinvy-firstinvy)/6)
coluna1:=firstinvx
coluna2:=(firstinvx+x)
coluna3:=(firstinvx+2*x)
coluna4:=(firstinvx+3*x)
linha1:= firstinvy
linha2:=(firstinvy+y)
linha3:=(firstinvy+2*y)
linha4:=(firstinvy+3*y)
linha5:=(firstinvy+4*y)
linha6:=(firstinvy+5*y)
linha7:=(firstinvy+6*y)

Loop %quantidade%{
	Pixelsearch,vermelhox,vermelhoy,870,79,1100,350,0x0000ff,5,fast
		If (errorlevel == 0){
			mousegetpos,mousex,mousey
			random,var1,10,25
			random,var2,10,15
			vermelhox+=var1
			vermelhoy+=var2
			RandomBezier(mousex, mousey,vermelhox,vermelhoy, "T300 OT15 OB15 OL15 OR15")
			Sleeptime(200,350)
			Click
			sleeptime(7500,8200)
		}
		if (errorlevel == 1){
		msgbox, nao achou vermelho
		}
gosub,Fireinv2a28

	Pixelsearch,rosax,rosay,800,480,980,600,0xff00ff,5,fast
		If (errorlevel == 0){
			mousegetpos,mousex,mousey
			random,var1,10,25
			random,var2,10,15
			rosax+=var1
			rosay+=var2
			RandomBezier(mousex, mousey,rosax,rosay, "T300 OT15 OB15 OL15 OR15")
			Sleeptime(200,350)
			Click
			sleeptime(6000,7500)
		}

			mousegetpos,mousex,mousey
			madeirax:=fcincox
			madeiray:=fcincoy
			random,var1,-15,15
			random,var2,-15,15
			madeirax+=var1
			madeiray+=var2
			RandomBezier(mousex, mousey,madeirax,madeiray, "T300 OT15 OB15 OL15 OR15")
			Sleeptime(200,350)
			Click
			sleeptime(450,800)
			send {esc}
			sleeptime(1000,1500)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;COPIA
Pixelsearch,azulx,azuly,900,150,1100,350,0xff0000,10,fast
		If (errorlevel == 0){
			mousegetpos,mousex,mousey
			random,var1,10,25
			random,var2,10,15
			azulx+=var1
			azuly+=var2
			RandomBezier(mousex, mousey,azulx,azuly, "T300 OT15 OB15 OL15 OR15")
			Sleeptime(200,350)
			Click
			sleeptime(7500,8200)
		}
		if (errorlevel == 1){
			msgbox, nao achou azul
		}
gosub,Fireinv2a28

	Pixelsearch,rosax,rosay,10,480,980,600,0xff00ff,5,fast
		If (errorlevel == 0){
			mousegetpos,mousex,mousey
			random,var1,10,25
			random,var2,10,15
			rosax+=var1
			rosay+=var2
			RandomBezier(mousex, mousey,rosax,rosay, "T300 OT15 OB15 OL15 OR15")
			Sleeptime(200,350)
			Click
			sleeptime(6000,7500)
		}

			mousegetpos,mousex,mousey
			madeirax:=fcincox
			madeiray:=fcincoy
			random,var1,-15,15
			random,var2,-15,15
			madeirax+=var1
			madeiray+=var2
			RandomBezier(mousex, mousey,madeirax,madeiray, "T300 OT15 OB15 OL15 OR15")
			Sleeptime(200,350)
			Click
			sleeptime(450,800)
			send {esc}
			sleeptime(1000,1500)

}



;msgbox, Script Finalizado. %itensfeitos% Runs. Garantindo %xpmade% xp.

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
Fireinv2a28:
contadorprimeiraqueima:=0
x := [1243, 1330, 1422, 1513, 1243, 1330, 1422, 1513, 1243, 1330, 1422, 1513, 1243, 1330, 1422, 1513, 1243, 1330, 1422, 1513, 1243, 1330, 1422, 1513, 1243, 1330, 1422, 1513]
y := [490, 490, 490, 490, 561, 561, 561, 561, 633, 633, 633, 633, 705, 705, 705, 705, 780, 780, 780, 780, 854, 854, 854, 854, 927, 927, 927, 927]
; Inicializar a variável "clicados" como um objeto vazio
clicados := {}
Loop, 27
{
	Clicktinderbox()
   ; Gerar um índice aleatório para selecionar um ponto
   Random, index, 2, 28
   	; Verificar se o índice já foi clicado antes
	While (clicados.HasKey(index))
	Random, index, 2, 28
   {
      ; Clicar no ponto
	mousegetpos,mousex, mousey
	random,varx,-20,20
	random,vary,-20,20
	x[index]+=varx
	y[index]+=vary
	RandomBezier(mousex, mousey,x[index],y[index], "T300 OT15 OB15 OL15 OR15")
	  sleeptime(150,300)
	  click
      ; Armazenar o índice do ponto clicado
      clicados[index] := 1
	If (contadorprimeiraqueima == 0){
	sleeptime(1900,2200)
	contadorprimeiraqueima++
	}else{
	sleeptime(1000,1100)
	}
   }
}
sleeptime(1500,1800)
return

; Definir as coordenadas dos pontos