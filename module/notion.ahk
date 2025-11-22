#Include "%A_ScriptDir%\module\lib\logger.ahk"

; --------------------------------------------------------------
; Notion Specifications
; Keyboard shortcuts https://www.notion.so/help/keyboard-shortcuts
;                    https://usethekeyboard.com/notion/
; --------------------------------------------------------------
#HotIf WinActive("ahk_exe Notion.exe")
; Main
; Create a new page (in the Mac/Windows app) with ⌘ + n
#n:: Send("^n")
; When creating a new page, select where to add the page. with ⌘ + shift + p
#+p:: Send("^+p")
; Open a new window (in the Mac/Windows app) with ⌘ + shift + n
#+n:: Send("^+n")
; Quickly jump to a page (Quick Find) with ⌘ + p
#p:: Send("^p")
; Go back with ⌘ + [
#[:: Send("^[")
; Go back with ⌘ + ]
#]:: Send("^]")
; Go up to the parent page with ⌘ + shift + u
#+u:: Send("^+u")
; Toggle the sidebar (in the Mac/Windows app) with ⌘ + \
#\:: Send("^\")

; Content Creation & Editing
; Create a comment with ⌘ + shift + m
#+m:: Send("^+m")
; Bold selected text with ⌘ + b
#b:: Send("^b")
; Italicize seleted text with ⌘ + i
#i:: Send("^i")
; Stike-through selected text with ⌘ + shift + s
#+s:: Send("^+s")
; Create a link with the selected text with ⌘ + k
#k:: Send("^k")
; Create text with ⌘ + option + 0
#!0:: Send("^!0")
; Create a heading 1 with ⌘ + option + 1
#!1:: Send("^!1")
; Create a heading 2 with ⌘ + option + 2
#!2:: Send("^!2")
; Create a heading 3 with ⌘ + option + 3
#!3:: Send("^!3")
; With text selected, inline code with ⌘ + e
#e:: Send("^e")

; While Blocks are Selected
; Expand the selection up or down with ⌘ + shift + left/right. FIXME: Does seem to be working
#+Left:: Send("^+{Left}")
#+Right:: Send("^+{Right}")
; Open a page in a new tab with ⌘ + shift + enter
#+Enter:: Send("^+{Enter}")
; Duplicate the blocks you have selected with ⌘ + d
#d:: Send("^d")
; Expand/close all toggles with ⌘ + option + t
#!t:: Send("^!t")
#HotIf

Logger.Info("Notion script loaded: " A_ScriptName, "Notion")
