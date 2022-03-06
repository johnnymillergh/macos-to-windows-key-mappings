; --------------------------------------------------------------
; Windows Terminal Specificications
; --------------------------------------------------------------
#If WinActive("ahk_exe WindowsTerminal.exe")
; New tab with ⌘ + t
#t::Send ^+t

; Close tab with ⌘ + w
#w::Send ^+w

; Find with ⌘ + f
#f::Send ^+f
