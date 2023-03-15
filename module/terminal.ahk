; --------------------------------------------------------------
; Windows Terminal Specificications
; --------------------------------------------------------------
#HotIf WinActive("ahk_exe WindowsTerminal.exe")
; New tab with ⌘ + t
#t::Send("^+t")

; Close tab with ⌘ + w
#w::Send("^w")

; Find with ⌘ + f
#f::Send("^+f")

; Open Command Palette with ⌘ + shift + p
#+p::Send("^+p")

; Open Windows PowerShell with ⌘ + 1
#1::Send("^+1")

; Open Ubuntu with ⌘ + 2
#2::Send("^+2")

; Open Git Bash with ⌘ + 3
#3::Send("^+3")

; Open Command Prompt with ⌘ + 4
#4::Send("^+4")
#HotIf
