; --------------------------------------------------------------
; Windows Built-in Softwares (File Explorer)
; Specificications
; --------------------------------------------------------------
#HotIf WinActive("ahk_exe explorer.exe")
; Crate a new folder with ⌘ + shift + enter
#+n::Send("^+n")
#HotIf
