; --------------------------------------------------------------
; Postman Specificications
; --------------------------------------------------------------
#HotIf WinActive("ahk_exe Postman.exe")
; Request
; Send Request with ⌘ + enter
#Enter::Send("^{Enter}")

; Windows and modals
; Settings with ⌘ + ,
#,::Send("^,")
; Open Shortcut Help with ⌘ + /
#/::Send("^/")
; Search with ⌘ + k
#k::Send("^k")
#HotIf
