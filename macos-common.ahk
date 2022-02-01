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
