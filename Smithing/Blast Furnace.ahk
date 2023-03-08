#SingleInstance, force
coordmode, mouse, screen
{ ;função de licença
   InternetTime() {
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", "http://1.1.1.1")
    whr.Send()
    gmt := whr.GetResponseHeader("Date")
    ts := ""
    if (RegExMatch(gmt, "(\d{2}) (\w{3}) (\d{4}) (\d{2}):(\d{2}):(\d{2})", $)) {
        $2 := {Jan:1, Feb:2, Mar:3, Apr:4, May:5, Jun:6, Jul:7, Aug:8, Sep:9, Oct:10, Nov:11, Dec:12}[$2]
        ts := $3 Format("{:02s}", $2) $1 $4 $5 $6
    }
    ObjRelease(whr)
    return ts
}

horacerta := InternetTime()
horacerta:= horacerta-30000
licenseexpiry:=20230308130000
licenseSeconds:=licenseexpiry
licenseSeconds -= horacerta, Seconds
NtpSvr := "de.pool.ntp.org"
NetTime := UTC_ToLocalTime(GetNetworkTime(NtpSvr))
licenseDays:=licenseSeconds//86400
licenseHours:=Floor((licenseSeconds-licenseDays*86400)/3600)
licenseminutes:=Floor((licenseSeconds-licenseDays*86400-licenseHours*3600)/60)
licenseminutesover:= (licenseSeconds-licenseDays*86400-licenseHours*3600-licenseminutes*60)

If (NetTime >= licenseexpiry){
    msgbox, Expired License
    ExitApp
}
If (NetTime < licenseexpiry){
    msgbox, You have %licenseDays% days, %licenseHours% hours,%licenseminutes% minutes and %licenseminutesover% seconds left on your license to use the software.
}
}
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
Scriptlist:="Gold Bar|Runite Bar|"
Gui, Add, Text, x12 y9 w60 h20 , Select Script
Gui, Add, DropDownList, x82 y9 w110 h100 vscriptlist gscriptlist , %Scriptlist%
Gui, Add, Button, x202 y9 w60 h20 gscriptinfo, Script Info
Gui, Add, Text, x52 y39 w80 h20 , Quantity of bars
Gui, Add, Edit, x132 y39 w40 h20 , 5000
Gui, Add, Text, x22 y69 w100 h20 +Right cred vftres, Stamina pot(1) - F3
Gui, Add, Text, x22 y99 w100 h20 +Right cred vfquatro, Ore 1(Bank) - F4
Gui, Add, Text, x22 y129 w100 h20 +Right cred vfcinco, Ore 2(Bank) - F5
Gui, Add, Text, x12 y169 w120 h20 +Right cred vfseis, Conveyor Belt x1y1 - F6
Gui, Add, Text, x12 y199 w120 h20 +Right cred vfsete, Conveyor Belt x2y2 - F7
Gui, Add, Text, x12 y229 w120 h20 +Right cred vfoito, Gloves (Inventory) - F8
Gui, Add, Text, x12 y269 w120 h20 +Right cred vfnove, Bar Dispenser x1y1 - F9
Gui, Add, Text, x12 y299 w120 h20 +Right cred vfdez, Bar Dispenser x2y2 - F10
Gui, Add, Text, x22 y339 w110 h20 +Right cred vfonze, Bank x1y1 - F11
Gui, Add, Text, x22 y369 w110 h20 +Right cred vfdoze, Bank x2y2 - F12
Gui, Add, Button, x132 y69 w20 h20 , ? ;f3
Gui, Add, Button, x132 y99 w20 h20 , ? ;f4
Gui, Add, Button, x132 y129 w20 h20 , ? ;f5
Gui, Add, Button, x142 y169 w20 h20 , ? ;f6
Gui, Add, Button, x142 y199 w20 h20 , ? ;f7
Gui, Add, Button, x142 y229 w20 h20 , ? ;f8
Gui, Add, Button, x142 y269 w20 h20 gquestionmarkf9, ? ;F9
Gui, Add, Button, x142 y299 w20 h20 gquestionmarkf10, ? ;f10
Gui, Add, Button, x142 y339 w20 h20 gquestionmarkf11, ? ;F11
Gui, Add, Button, x142 y369 w20 h20 gquestionmarkf12, ? ;f12
Gui, Add, Text, x182 y99 w70 h20 cblue, OPEN BANK
Gui, Add, Text, x182 y179 w70 h50 cblue, CLOSE BANK INTERFACE`, STAND ON BANK SPOT
Gui, Add, Text, x182 y279 w60 h40 cblue, STAND ON CONVEYOR BELT
Gui, Add, Text, x182 y349 w70 h40 cblue, STAND ON DISPENSER
Gui, Add, Button, x12 y399 w110 h40 gruneliteoptimalsetup, Runelite Optimal setup. (Suggested, not required)
Gui, Add, Button, x142 y399 w110 h40 gstartbutton , Start(F1)
Gui, Add, GroupBox, x12 y59 w240 h100 ,
Gui, Add, GroupBox, x12 y159 w240 h90 ,
Gui, Add, GroupBox, x12 y259 w240 h70 ,
Gui, Add, GroupBox, x12 y329 w240 h70 ,
Gui, Show, w273 h459, Blast Furnace v1.0
return



Gui, Add, Button, x112 y159 w80 h20 , Start
Gui, Add, DropDownList, x72 y9 w120 h200  vscript, %Scriptlist%
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


F2::
Reload
GuiClose:
ExitApp

{ ;;Funções Label F5 a F12 e outras
f3::
mousegetpos,ftresx, ftresy
;guicontrol, , foito, Done!
gui,font,cgreen
guicontrol,font,ftres
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
startbutton: ;;start button function
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
scriptlist: ;script selected
gui,submit,nohide
return
scriptinfo:
if (scriptlist == "Gold Bar|Runite Bar|"){
	msgbox, First, choose the script you want to receive a detailed description of what it does.
	return
}
if (scriptlist == "Gold Bar"){
	msgbox, This script gathers gold ore and transforms it into gold bars using the Blast Furnace. Don't forget to leave money in the coffer.
	return
}
if (scriptlist == "Runite Bar"){
	msgbox, This script is still in development.
	return
}
return
runeliteoptimalsetup:
return
questionmarkf9:
return
questionmarkf10:
return
questionmarkf11:
return
questionmarkf12:
return
{ ;Funtion to get Time
	/* syntax :
	NtpSvr := "de.pool.ntp.org"
	NetTime := UTC_ToLocalTime(GetNetworkTime(NtpSvr))
	If (NetTime >= 20230307234149){
	}
	*/
GetNetworkTime(Server := "time.windows.com", Port := 123, Timeout := 1000) {
   ; stackoverflow.com/questions/1193955/how-to-query-an-ntp-server-using-c
   ; www.cisco.com/c/en/us/about/press/internet-protocol-journal/back-issues/table-contents-58/154-ntp.html
   If !(Ws2 := DllCall("LoadLibrary", "Str", "Ws2_32.dll", "UPtr")) {
      Msg := "Ws2_32.dll could not be loaded!"
      Return GetNetworkTime_Error(Msg, Ws2, 0, 0)
   }
   ; -----------------------------------------------------------------------------------------------------------------------------
   ; Initialize the Winsock library - request Winsock 2.2
   VarSetCapacity(WsaData, 512, 0) ; more than sufficient
   If (Error := DllCall("Ws2_32.dll\WSAStartup", "UShort", 0x0202, "UInt", &WsaData, "Int")) {
      Msg := "WSAStartup() failed with error " . Error
      Return GetNetworkTime_Error(Msg, Ws2, 0, 0)
   }
   ; -----------------------------------------------------------------------------------------------------------------------------
   ; Name resolution
   If !(HostEnt := DllCall("Ws2_32.dll\gethostbyname", "AStr", Server, "UPtr")) {
      Msg := "gethostbyname() failed with error " . DllCall("Ws2_32.dll\WSAGetLastError", "Int")
      Return GetNetworkTime_Error(Msg, Ws2, 1, 0)
   }
   AddrList := NumGet(HostEnt + 0, (2 * A_PtrSize) + 4 + (A_PtrSize - 4), "UPtr")
   IpAddr := NumGet(AddrList + 0, 0, "UPtr")
   Addr := StrGet(DllCall("Ws2_32.dll\inet_ntoa", "UInt", NumGet(IpAddr + 0, 0, "UInt"), "UPtr"), "CP0")
   InetAddr := DllCall("Ws2_32.dll\inet_addr", "AStr", Addr, "UInt") ; convert address to 32-bit UInt
   If (InetAddr = 0xFFFFFFFF) { ; INADDR_NONE
      Msg := "inet_addr() failed for address " . Addr
      Return GetNetworkTime_Error(Msg, Ws2, 1, 0)
   }
   ; -----------------------------------------------------------------------------------------------------------------------------
   ; Create a socket: AF_INET = 2, SOCK_DGRAM = 2, IPPROTO_UDP = 17
   Socket := DllCall("Ws2_32.dll\socket", "UInt", 2, "UInt", 2, "UInt", 17, "UPtr")
   If (Socket = 0xFFFFFFFF) { ; INVALID_SOCKET
      Msg := "socket() indicated Winsock error " . DllCall("Ws2_32.dll\WSAGetLastError")
      Return GetNetworkTime_Error(Msg, Ws2, 1, 0)
   }
   ; -----------------------------------------------------------------------------------------------------------------------------
   ; Connect to the socket
   VarSetCapacity(SocketAddr, 16, 0) ; size of sockaddr = 16
   NumPut(2, SocketAddr, 0, "Short") ; sin_family = AF_INET
   NumPut(DllCall("Ws2_32.dll\htons", "UShort", Port), SocketAddr, 2, "UShort") ; sin_port
   Numput(InetAddr, SocketAddr, 4, "UInt") ; sin_addr.s_addr
   If DllCall("Ws2_32.dll\connect", "Ptr", Socket, "UInt", &SocketAddr, "Int", 16) {
      Msg := "connect() indicated Winsock error " . DllCall("Ws2_32.dll\WSAGetLastError")
      Return GetNetworkTime_Error(Msg, Ws2, 1, Socket)
   }
   ; -----------------------------------------------------------------------------------------------------------------------------
   ; Set the timeout for recv: SOL_SOCKET = 0xFFFF, SO_RCVTIMEO = 0x1006, SOCKET_ERROR = -1
   If (DllCall("Ws2_32.dll\setsockopt", "Ptr", Socket, "Int", 0xFFFF, "Int", 0x1006, "IntP", Timeout, "Int", 4, "Int") = -1) {
      Msg := "setsockopt() indicated Winsock error " . DllCall("Ws2_32.dll\WSAGetLastError")
      Return GetNetworkTime_Error(Msg, Ws2, 1, Socket)
   }
   ; -----------------------------------------------------------------------------------------------------------------------------
   ; Send an NTP request
   VarSetCapacity(Data, 48, 0) ; NTP needs 48 bytes of data
   NumPut(0x1B, Data, "UChar") ; LI = 0 (no warning), VN = 3 (IPv4 only), Mode = 3 (Client Mode) -> 00 011 011
   If (DllCall("Ws2_32.dll\send", "Ptr", Socket, "Str", Data, "Int", 48, "Int", 0, "Int") = -1) { ; SOCKET_ERROR = -1
      Msg := "send() indicated Winsock error " . DllCall("Ws2_32.dll\WSAGetLastError")
      Return GetNetworkTime_Error(Msg, Ws2, 1, Socket)
   }
   ; -----------------------------------------------------------------------------------------------------------------------------
   ; Shutdown sending
   DllCall("Ws2_32.dll\shutdown", "Ptr", Socket, "Int", 1) ; SD_SEND = 1
   ; -----------------------------------------------------------------------------------------------------------------------------
   ; Get the answer
   If (DllCall("Ws2_32.dll\recv", "Ptr", Socket, "Ptr", &Data, "Int", 48, "Int", 0, "Int") = -1) { ; SOCKET_ERROR = -1
      Msg := "recv() indicated Winsock error " . DllCall("Ws2_32.dll\WSAGetLastError")
      Return GetNetworkTime_Error(Msg, Ws2, 1, Socket)
   }
   ; -----------------------------------------------------------------------------------------------------------------------------
   ; Free resources
   DllCall("Ws2_32.dll\closesocket", "Ptr", Socket)
   DllCall("Ws2_32.dll\WSACleanup") ; Terminate the use of the Winsock 2 DLL
   DllCall("FreeLibrary", "Ptr", Ws2)
   ; -----------------------------------------------------------------------------------------------------------------------------
   ; Get the time, we have to swap the byte order
   Sek := (NumGet(Data, 40, "Uchar") << 24) | (NumGet(Data, 41, "Uchar") << 16) | (NumGet(Data, 42, "Uchar") << 8)
         | NumGet(Data, 43, "Uchar")
   DT := "19000101"
   DT += Sek, S
   Return DT
}
; ================================================================================================================================
GetNetworkTime_Error(Msg, HMOD, Startup, Socket) {
   MsgBox, 16, %A_ThisFunc%, %Msg%
   If (Socket)
      DllCall("Ws2_32.dll\closesocket", "Ptr", Socket)
   If (Startup)
      DllCall("Ws2_32.dll\WSACleanup") ; Terminate the use of the Winsock 2 DLL
   If (HMOD)
      DllCall("FreeLibrary", "Ptr", HMOD)
   Return 0
}
; ================================================================================================================================
; UTC functions
; ================================================================================================================================
UTC_ToLocalTime(UTC := "") { ; UTC : (partial) date-time stamp (YYYYMMDDHH24MISS)
   UTC += 0, S
   If UTC Is Not Time
      Return ""
   UTC_TS2SYSTEMTIME(UTC, UTCTime)
   VarSetCapacity(LocTime, 16, 0)
   DllCall("SystemTimeToTzSpecificLocalTime", "Ptr", 0, "Ptr", &UTCTime, "Ptr", &LocTime)
   Return UTC_SYSTEMTIME2TS(LocTime)
}
; --------------------------------------------------------------------------------------------------------------------------------
UTC_FromLocalTime(Local := "") { ; Local : (partial) date-time stamp (YYYYMMDDHH24MISS)
   Local += 0, S
   If Local Is Not Time
      Return ""
   UTC_TS2SYSTEMTIME(Local, LocTime)
   VarSetCapacity(UTCTime, 16, 0)
   DllCall("TzSpecificLocalTimeToSystemTime", "Ptr", 0, "Ptr", &LocTime, "Ptr", &UTCTime)
   Return UTC_SYSTEMTIME2TS(UTCTime)
}
; --------------------------------------------------------------------------------------------------------------------------------
UTC_TS2SYSTEMTIME(TS, ByRef SYSTEMTIME) { ; Date-time stamp to SYSTEMTIME
   VarSetCapacity(SYSTEMTIME, 16, 0)
   NumPut(SubStr(TS, 1, 4), SYSTEMTIME, 0, "UShort")
   NumPut(SubStr(TS, 5, 2), SYSTEMTIME, 2, "UShort")
   NumPut(SubStr(TS, 7, 2), SYSTEMTIME, 6, "UShort")
   NumPut(SubStr(TS, 9, 2), SYSTEMTIME, 8, "UShort")
   NumPut(SubStr(TS, 11, 2), SYSTEMTIME, 10, "UShort")
   NumPut(SubStr(TS, 13, 2), SYSTEMTIME, 12, "UShort")
   Return &SYSTEMTIME
}
; --------------------------------------------------------------------------------------------------------------------------------
UTC_SYSTEMTIME2TS(ByRef SYSTEMTIME) { ; SYSTEMTIME to date-time stamp
   YYYY := NumGet(SYSTEMTIME, 0, "UShort")
   MM := NumGet(SYSTEMTIME, 2, "UShort")
   DD := NumGet(SYSTEMTIME, 6, "UShort")
   HH := NumGet(SYSTEMTIME, 8, "UShort")
   MN := NumGet(SYSTEMTIME, 10, "UShort")
   SS := NumGet(SYSTEMTIME, 12, "UShort")
   Return Format("{:04}{:02}{:02}{:02}{:02}{:02}", YYYY, MM, DD, HH, MN, SS)
}
}

;$OBFUSCATOR: $END_AUTOEXECUTE: