#Include "%A_ScriptDir%\module\lib\logger.ahk"

; --------------------------------------------------------------
; IM app (QQ, WeChat, WeCom, Teams, Slack, Lark, DingTalk)
; Specifications
; --------------------------------------------------------------
#HotIf WinActive("ahk_exe QQ.exe")
or WinActive("ahk_exe Weixin.exe")
or WinActive("ahk_exe WXWork.exe")
or WinActive("ahk_exe Teams.exe")
or WinActive("ahk_exe Slack.exe")
or WinActive("ahk_exe Lark.exe")
or WinActive("ahk_exe DingTalk.exe")

; Send message with ⌘ + enter
#Enter:: Send("^{Enter}")

; Minimize window with ⌘ + w
#w:: WinMinimize("a")
#HotIf

Logger.Info("IM script loaded: " A_ScriptName, "IM")
