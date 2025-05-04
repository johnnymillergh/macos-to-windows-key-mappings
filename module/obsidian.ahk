; --------------------------------------------------------------
; Obsidian Specifications
; --------------------------------------------------------------
#HotIf WinActive("ahk_exe Obsidian.exe")
; Open settings with ⌘ + ,
#,::Send("^,")

; Open command palette with ⌘ + p
#p::Send("^p")
; Search current file
#f::Send("^f")
; Search in all files
#+f::Send("^+f")

; --------------------- Paragraph Section ----------------------
; Plugin https://github.com/ryjjin/Obsidian-shortcuts-extender
; Heading 1 to 6 with ⌘ + 1 to 6
#1::Send("^1")
#2::Send("^2")
#3::Send("^3")
#4::Send("^4")
#5::Send("^5")
#6::Send("^6")
; Need to change the shortcut in Obsidian.
; 1. Toggle a code block with ⌘ + alt + c
; 2. Toggle bullet list with ⌘ + alt + u
; 3. Toggle numbered list with ⌘ + alt + o
; 4. Toggle checkbox with ⌘ + alt + x

; ---------------------- Format Section -----------------------
; Toggle bold with ⌘ + b
#b::Send("^b")
; Toggle italic with ⌘ + i
#i::Send("^i")
; Hyperlink with ⌘ + k
#k::Send("^k")
; Need to change the shortcut in Obsidian.
; 1. Toggle strikethrough with ⌘ + shift + `
; 2. Insert attachment with ⌘ + ctrl + i

; ----------------------- View Section ------------------------
; Need to change the shourcut in Obsidian.
; 1. Toggle Live Preview/Source mode with ctrl + alt + m
#/::Send("^!m")

; ---------------------- Linter Section -----------------------
; Plugin https://github.com/platers/obsidian-linter
; Lint the current file with ⌘ + alt + l
#!l::Send("^!l")

; Close active pane with ⌘ + w
#w::Send("^w")
; Undo close pane with ⌘ + shift + t
#+t::Send("^+t")
; Create new note with ⌘ + n
#n::Send("^n")
; Create new note in new pane with ⌘ + shift + n
#+n::Send("^+n")
#HotIf
