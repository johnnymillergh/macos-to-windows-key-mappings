; --------------------------------------------------------------
; macOS Common Shortcuts
; --------------------------------------------------------------
; Saving. Make ctrl + s work with ⌘ + s
#s::Send ^s

; Selecting
#a::Send ^a

; Delete current line with ⌘ + delete
#Backspace::Send ^{Backspace}

; Copying
#c::Send ^c

; Pasting
#v::Send ^v

; Paste without formatting with ⌘ + shift + v
#+v::Send ^+v

; Cutting
#x::Send ^x

; Opening
#o::Send ^o

; Finding
#f::Send ^f

; Replace / Reload
#r::Send ^r

; Undo
#z::Send ^z

; Redo
#y::Send ^y

; New tab
#t::Send ^t

; Close tab
#w::Send ^w

; Close window (⌘ + q to Alt + F4)
#q::Send !{F4}

; Remap Windows + Tab to Alt + Tab.
Lwin & Tab::AltTab

; Minimize window
#m::WinMinimize,a

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
