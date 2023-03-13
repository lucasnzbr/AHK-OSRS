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
mytime:=InternetTime()
licenseexpiry:=20240307235049

; Convert licenseexpiry to FileTime format
fileTime := DllCall("SystemTimeToFileTime", "int64", StrFormat("%016x", licenseexpiry), "int64*", 0)

; Convert mytime to FileTime format
myTime := InternetTime()
fileTime2 := DllCall("SystemTimeToFileTime", "str", myTime, "int64*", 0)

; Calculate the time difference in milliseconds
diff := fileTime - fileTime2
diff_ms := diff // 10000
diff_s := diff_ms // 1000

; Display the time difference in seconds
MsgBox The time difference is %diff_s% seconds (%diff_ms% milliseconds).
