; --------------------------------------------------------------
; IM app (WeChat, WeCom, Teams, Slack, Lark) Specificications
; --------------------------------------------------------------
#If WinActive("ahk_class WeChatMainWndForPC")
or WinActive("ahk_exe WXWork.exe")
or WinActive("ahk_exe Teams.exe")
or WinActive("ahk_exe Slack.exe")
or WinActive("ahk_exe Lark.exe")
; Send message with ⌘ + enter
#Enter::Send, ^{Enter}

; Minimize window with ⌘ + w
#w::WinMinimize,a
#If
