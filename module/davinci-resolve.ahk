#Include "%A_ScriptDir%\module\lib\logger.ahk"

; --------------------------------------------------------------
; DaVinCi Resolve Keyboard Shortcuts Specifications
; https://tutorialtactic.com/blog/davinci-resolve-shortcuts/
; --------------------------------------------------------------
#HotIf WinActive("ahk_exe Resolve.exe")
; File Shortcuts
; New bin with ⌘ + shift + n
#+n:: Send("^+n")
; New timeline with ⌘ + n
#n:: Send("^n")
; Edit Shortcuts
; Redo with ⌘ + shift + z
#+z:: Send("^+z")
; Cut with ⌘ + x
#x:: Send("^x")
; Deselect all with ⌘ + shift + a
#^a:: Send("^+a")
; Razor with ⌘ + b
#b:: Send("^b")
; Split clip with ⌘ + \
#\:: Send("^\")
; Reset clip with ⌘ + option + r
#!r:: Send("^!r")
; Enable\Disable selected nodes with ⌘ + d
#d:: Send("^d")
#HotIf

Logger.Info("DaVinci Resolve script loaded: " A_ScriptName, "Resolve")
