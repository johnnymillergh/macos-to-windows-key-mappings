#Include "%A_ScriptDir%\module\logger.ahk"

; --------------------------------------------------------------
; Windows Built-in Softwares (File Explorer)
; Specifications
; --------------------------------------------------------------
#HotIf WinActive("ahk_exe explorer.exe")
; Crate a new folder with ⌘ + shift + enter
#+n:: Send("^+n")
#HotIf

; Logger.Info("Windows Built-in Software script loaded: " A_ScriptName, "Windows")
