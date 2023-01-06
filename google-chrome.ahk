; --------------------------------------------------------------
; Google Chrome Specificications
; --------------------------------------------------------------
#HotIf WinActive("ahk_exe chrome.exe")
; Show Web Developer Tools with ⌘ + alt + i
#!i::Send("{F12}")

; Select an element with ⌘ + shift + c
#+c::Send("^+c")

; Show source code with ⌘ + alt + u
#!u::Send("^u")

; Restore web page with ⌘ + shift + t
#+t::Send("^+t")

; Select an element in the page and inspect it with alt + shift + c
!+c::Send("^+c")

; Switch to tab 1 with ⌘ + 1
#1::Send("^1")

; Switch to tab 2 with ⌘ + 2
#2::Send("^2")

; Switch to tab 3 with ⌘ + 3
#3::Send("^3")

; Switch to tab 4 with ⌘ + 4
#4::Send("^4")

; Switch to tab 5 with ⌘ + 5
#5::Send("^5")

; Switch to tab 6 with ⌘ + 6
#6::Send("^6")

; Print the current page with ⌘ + p
#p::Send("^p")

; Chrome extension: https://github.com/alyssaxuu/omni with ⌘ + shift + k
#+k::Send("^+k")

; Open an incognito window with ⌘ + Shift + n
#+n::Send("^+n")
#HotIf
