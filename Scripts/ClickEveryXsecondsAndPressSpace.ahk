#SingleInstance, force
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

/* ;;tutorial and usage RandomBezier

 X0, Y0, Xf, Yf [, O]

 + Required parameters:
 - X0 and Y0     The initial coordinates of the mouse movement
 - Xf and Yf     The final coordinates of the mouse movement

 + Optional parameters:
 - O             Options string, see remarks below (default: blank)

 It is possible to specify multiple (case insensitive) options:

 # "Tx" (where x is a positive number)
   > The time of the mouse movement, in miliseconds
   > Defaults to 200 if not present
 # "RO"
   > Consider the origin coordinates (X0,Y0) as relative
   > Defaults to "not relative" if not present
 # "RD"
   > Consider the destination coordinates (Xf,Yf) as relative
   > Defaults to "not relative" if not present
 # "Px" or "Py-z" (where x, y and z are positive numbers)
   > "Px" uses exactly 'x' control points
   > "Py-z" uses a random number of points (from 'y' to 'z', inclusive)
   > Specifying 1 anywhere will be replaced by 2 instead
   > Specifying a number greater than 19 anywhere will be replaced by 19
   > Defaults to "P2-5"
 # "OTx" (where x is a number) means Offset Top
 # "OBx" (where x is a number) means Offset Bottom
 # "OLx" (where x is a number) means Offset Left
 # "ORx" (where x is a number) means Offset Right
   > These offsets, specified in pixels, are actually boundaries that
     apply to the [X0,Y0,Xf,Yf] rectangle, making it wider or narrower
   > It is possible to use multiple offsets at the same time
   > When not specified, an offset defaults to 100
     - This means that, if none are specified, the random Bézier control
       points will be generated within a box that is wider by 100 pixels
       in all directions, and the trajectory will never go beyond that

EXAMPLE
MouseGetPos, MouseX, MouseY
RandomBezier( MouseX, MouseY, DestinationX, DestinationY, "options string without the REL part" )

*/
;;Time can be specified after a "T" in the options string.
;;
;;If you want to achieve a random time, you can do this:
;;
;;Random, RandTime, 500, 3000 ; time in milliseconds
;;RandomBezier( OrigX, OrigY, DestinationX, DestinationY, "some_options T" RandTime " some_other_options" )

;; Variaveis e User input;;

	Inputbox, invlimit, Number of Items, Enter the number of clicks you'd like to complete
	Inputbox, sleeptime, Miliseconds of sleep, Enter the minimum time between clicks in MILISECONDS
	;;Inputbox, antibanswitch, Use Antiban?, Press 1 for antiban usage anything else for not using it

random, bussolax, 24, 38
random, bussolay, 78, 95
random, layoutbuttonx, 750, 930
random, layoutbuttony, 600, 610
random, rs3defx, 750, 930
random, rs3defy, 625, 634
random, sleep1, 500, 1000
random, sleep2, 1000, 2500
random, sleep3, 2500, 5000
random, sleep4, 5000, 10000



;;Ceil(Number): Returns Number rounded up to the nearest integer (without any .00 suffix). For example, Ceil(1.2) is 2 and Ceil(-1.2) is -1.
;;Floor(Number): Returns Number rounded down to the nearest integer (without any .00 suffix). For example, Floor(1.2) is 1 and Floor(-1.2) is -2.



;; Variaveis Globais;;
		global invcount := 0
		global g1 := 0
		global g2 := 0
		global g3 := 0
		global g4 := 0
		global g5 := 0
		global g6 := 0

;;functions;;


#singleinstance force

sleeptime(min,max){
	random,var,min,Max
	sleep var
}

F1::
StartTime := A_TickCount

loop %invlimit%
	{
Click
sleeptime(1400,2700)
send {space}
sleeptime2:=sleeptime+3500
sleeptime(sleeptime,sleeptime2)
	}

ElapsedTime := A_TickCount - StartTime
elapsedtimecorrected := (elapsedtime/1000)
invlimit60 := (invlimit*60)
Msgbox Finished running the script, the loop was executed %invcount% times.


F2:: reload
F3:: exitapp
