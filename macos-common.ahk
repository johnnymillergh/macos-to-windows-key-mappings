; --------------------------------------------------------------
; macOS Common Shortcuts
; https://support.apple.com/en-us/HT201236
; --------------------------------------------------------------
; Saving with ⌘ + s
#s::Send("^s")

; Selecting with ⌘ + a
#a::Send("^a")

; Delete current line with ⌘ + delete
#Backspace::Send("^{Backspace}")

; Copying with ⌘ + c
#c::Send("^c")

; Pasting with ⌘ + v
#v::Send("^v")

; Paste without formatting with ⌘ + shift + v
#+v::Send("^+v")

; Cutting with ⌘ + x
#x::Send("^x")

; Opening with ⌘ + o
#o::Send("^o")

; Finding with ⌘ + f
#f::Send("^f")

; Replace / Reload with ⌘ + r
#r::Send("^r")

; Undo with ⌘ + z
#z::Send("^z")

; Redo with ⌘ + y
#y::Send("^y")

; New tab with ⌘ + t
#t::Send("^t")

; Close tab with ⌘ + w
#w::Send("^w")

; Close window with ⌘ + q
#q::Send("!{F4}")

; Remap Windows + Tab to Alt + Tab.
Lwin & Tab::AltTab

; Minimize window with ⌘ + m
#m::WinMinimize("a")

; --------------------------------------------------------------
; Mac-like screenshots in Windows (requires Windows 10 Snip & Sketch)
; --------------------------------------------------------------
; Capture entire screen with ⌘ + shift + 3. F1 is the shortcut for Snipaste
#+3::Send("{F1}")

; Capture portion of the screen with ⌘ + shift + 4
;#+4::#+s

; --------------------------------------------------------------
; OS X keyboard mappings for special chars
; --------------------------------------------------------------
; Map Alt + L to @
;!l::SendInput {@}

; Map Alt + N to \
;+!7::SendInput {\}

; Map Alt + N to ©
;!g::SendInput {©}

; Map Alt + o to ø
;!o::SendInput {ø}

; Map Alt + 5 to [
;!5::SendInput {[}

; Map Alt + 6 to ]
;!6::SendInput {]}

; Map Alt + E to €
;!e::SendInput {€}

; Map Alt + - to –
;!-::SendInput {–}

; Map Alt + 8 to {
;!8::SendInput {{}

; Map Alt + 9 to }
;!9::SendInput {}}

; Map Alt + - to ±
;!+::SendInput {±}

; Map Alt + R to ®
;!r::SendInput {®}

; Map Alt + N to |
;!7::SendInput {|}

; Map Alt + W to ∑
;!w::SendInput {∑}

; Map Alt + N to ~
;!n::SendInput {~}

; Map Alt + 3 to #
;!3::SendInput {#}

; --------------------------------------------------------------
; Custom mappings for special chars
; --------------------------------------------------------------
;#ö::SendInput {[}
;#ä::SendInput {]}
;^ö::SendInput {{}
;^ä::SendInput {}}
