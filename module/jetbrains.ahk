; --------------------------------------------------------------
; JetBrains Specificications
; This mappings also work with Visual Studio Code with the plugin "IntelliJ IDEA Keybindings"
; --------------------------------------------------------------
#HotIf WinActive("ahk_exe idea64.exe")
    or WinActive("ahk_exe pycharm64.exe")
or WinActive("ahk_exe datagrip64.exe")
or WinActive("ahk_exe webstorm64.exe")
or WinActive("ahk_exe Code.exe")
; Auto-complementation current line and return new line
#+Enter::^+Enter

; Globally find with ⌘ + shift + f
#+f::Send("^+f")

; Globally replace with ⌘ + shift + r
#+r::Send("^+r")

; Code formatting with ⌘ + alt + l
#!l::Send("^!l")

; Go into the code with ⌘ + LeftClick
#LButton::Send("^{LButton}")

; Go into the implementation with ⌘ + alt + LeftClick
#!LButton::Send("^!{LButton}")

; Accept value with type with ⌘ + alt + v
#!v::Send("^!v")

; Copy current line with ⌘ + d
#d::Send("^d")

; Delete current line with ⌘ + backspace
#Backspace::Send("^y")

; Comment current line with ⌘ + /
#/::Send("^/")

; Comment multiple lines with ⌘ + shift + /
#+/::Send("^+/")

; Optimize imports with alt + shift + o, seems like all platforms have the same shortcut, which is control + alt + o
;!+o::Send ^!o

; Close editor's tab with ⌘ + w
#w::Send("^{F4}")

; Open Settings with ⌘ + .
#,::Send("^!s")

; Collapse with ⌘ + -
#-::Send("^-")

; Expand with ⌘ + +，this shortcut is not working on Windows, confecting with the application ("C:\Windows\System32\Magnify.exe")
#+::Send("^+")

; Collapse all with ⌘ + -
#+-::Send("^+-")

; Expand all with ⌘ + +
#++::Send("^+{+}")

; Previous with ⌘ + left
#!Left::Send("^!{Left}")

; Next with ⌘ + right
#!Right::Send("^!{Right}")

; Recent files with ⌘ + e
#e::Send("^e")

; Split line, submit, execute SQL with ⌘ + enter
#Enter::Send("^{Enter}")

; Highlight current scope with ⌘ + RightClick
#RButton::Send("^{RButton}")

; Move statement up with ⌘ + shift + up
#+Up::Send("^+{Up}")

; Move statement down with ⌘ + shift + down
#+Down::Send("^+{Down}")

; Code generation with ctrl + enter, FIXME: doesn't work properly
^Enter::Send("!{Ins}")

; Copy class name or method reference with ⌘ + shift + alt + c
#+!c::Send("^+!c")

; Surround / with ⌘ + alt + t
#!t::Send("^!t")

; Toggle case with ⌘ + shift + u
#+u::Send("^+u")

; Type hierachy with ⌘ + h
#h::Send("^h")

; Method hierarchy with ⌘ + shift + h
#+h::Send("^+h")

; Call hierarchy with ⌘ + alt + h
#!h::Send("^!h")

; Git
; Git commit with ⌘ + k
#k::Send("^k")
; Git push with ⌘ + shift + k
#+k::Send("^+k")
; Git pull with ⌘ + t
#t::Send("^t")
; Git rollback with ⌘ + alt + z
#!z::Send("^!z")
; Git new branch with ⌘ + option + n
#!n::Send("^!n")
#HotIf
