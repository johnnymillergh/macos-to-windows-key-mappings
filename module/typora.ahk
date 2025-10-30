#Include "%A_ScriptDir%\module\logger.ahk"

; --------------------------------------------------------------
; Typora Specifications
; --------------------------------------------------------------
#HotIf WinActive("ahk_exe Typora.exe")
; New with ⌘ + n
#n:: Send("^n")

; Paragraph
; Heading 1 to 6 with ⌘ + 1 to 6
#1:: Send("^1")
#2:: Send("^2")
#3:: Send("^3")
#4:: Send("^4")
#5:: Send("^5")
#6:: Send("^6")
; Paragraph with ⌘ + o
#o:: Send("^o")
; Table with ⌘ + alt +t
#!t:: Send("^t")
; Code Fences with ⌘ + alt + c
#!c:: Send("^+k")
; Quote with ⌘ + alt + q
#!q:: Send("^+q")
; Ordered List with ⌘ + alt + o
#!o:: Send("^+[")
; Unordered List with ⌘ + alt + u
#!u:: Send("^+]")
; Task list with ⌘ + alt + x
#!x:: Send("^+x")

; Format
; Strong with ⌘ + b
#b:: Send("^b")
; Emphasis with ⌘ + i
#i:: Send("^i")
; Underline with ⌘ + u
#u:: Send("^u")
; Code with ⌘ + shift + `, FIXME: this doesn't work well
#+Del:: Send("^+{Del}")
; Strikethrough with ⌘ + shift + `
#^Del:: Send("^+5")
; Hyperlink with ⌘ + k
#k:: Send("^k")
; Image with ⌘ + ctrl + i
#^i:: Send("^+i")

; View
; Source Code Mode with ⌘ + /
#/:: Send("^/")
#HotIf

Logger.Info("Typora script loaded: " A_ScriptName, "Typora")
