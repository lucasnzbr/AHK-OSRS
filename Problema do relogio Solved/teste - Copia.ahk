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
remote := InternetTime()
diff := 20230308232500
;diff:=(diff-remote), seconds
diff -= remote, Seconds
;MsgBox %diff% %test%
;MsgBox % Format("Remote:`t{}`nLocal:`t{}`nDiff:`t{}", remote, A_NowUTC, diff)
MsgBox %diff%