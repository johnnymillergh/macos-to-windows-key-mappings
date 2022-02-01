#If WinActive("ahk_class WeChatMainWndForPC") or WinActive("ahk_exe WXWork.exe") or WinActive("ahk_exe Teams.exe") or WinActive("ahk_exe Slack.exe")
; Send message with ⌘ + enter
#Enter::Send, ^{Enter}

; Minimize window with ⌘ + w
#w::WinMinimize,a

; Paste without formatting with ⌘ + shift + v
#+v::Send ^+v
#If
