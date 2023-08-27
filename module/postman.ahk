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
; Beautify JavaScript with ⌘ + b, https://community.postman.com/t/any-way-to-align-format-lint-code-in-tests-block-in-postman/12277
#b::Send("^b")
#HotIf
