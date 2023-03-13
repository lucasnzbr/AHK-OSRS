#NoEnv
SetBatchLines, -1
NtpSvr := "de.pool.ntp.org"
S := A_TickCount
NetTime := UTC_ToLocalTime(GetNetworkTime(NtpSvr))
T := A_TickCOunt - S
MsgBox, 0, %NtpSvr% (%T% ms), %NetTime%
ExitApp

; ================================================================================================================================
; Server    -  The name of the NTP server to query.
;              Default: time.windows.com
; Port      -  The number of the port to query.
;              Default: 123
; Timeout   -  The number of milliseconds the client will wait for a response.
;              Default: 1000
; ================================================================================================================================
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