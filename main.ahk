;-----------------------------------------
; macOS Keyboard to Windows Key Mappings
;=========================================

; --------------------------------------------------------------
; Quick Reference
; --------------------------------------------------------------
; ! = Option (or Alt) ⌥
; ^ = CTRL ⌃
; + = SHIFT ⇧
; # = WIN, Command (or Cmd) ⌘
;
; Debug action snippet: MsgBox You pressed Control-A while Notepad is active.
; MsgBox, 4, , 4-parameter method: this MsgBox will time out in 5 seconds.  Continue?, 5
; --------------------------------------------------------------

#InstallKeybdHook
#SingleInstance force
SetTitleMatchMode 2
SendMode Input

; --------------------------------------------------------------
; media/function keys all mapped to the right option key
; --------------------------------------------------------------
;RAlt & F7::SendInput {Media_Prev}
;RAlt & F8::SendInput {Media_Play_Pause}
;RAlt & F9::SendInput {Media_Next}
;F10::SendInput {Volume_Mute}
;F11::SendInput {Volume_Down}
;F12::SendInput {Volume_Up}

; swap left ⌘/WIN with left alt
;LWin::LAlt
;LAlt::LWin ; add a semicolon in front of this line if you want to disable the WIN key

; Remap Windows + Left OR Right to enable previous or next web page
; Use only if swapping left ⌘/WIN key with left alt
Lwin & Left::Send !{Left}
Lwin & Right::Send !{Right}

; Eject Key
;F20::SendInput {Insert} ; F20 doesn't show up on AHK anymore, see #3

; F13-15, standard Windows mapping
;F13::SendInput {PrintScreen}
;F14::SendInput {ScrollLock}
;F15::SendInput {Pause}

;F16-19 custom app launchers, see http://www.autohotkey.com/docs/Tutorial.htm for usage info
;F16::Run https://twitter.com
;F17::Run https://linkedin.com
;F18::Run https://www.reddit.com
;F19::Run https://facebook.com

; --------------------------------------------------------------
; macOS System Shortcuts
; --------------------------------------------------------------
#Include %A_ScriptDir%\macos-common.ahk

; --------------------------------------------------------------
; Google Chrome Specificications
; --------------------------------------------------------------
#Include %A_ScriptDir%\google-chrome.ahk

; --------------------------------------------------------------
; JetBrains Specificications
; This mappings also work with Visual Studio Code with the plugin "IntelliJ IDEA Keybindings"
; --------------------------------------------------------------
#Include %A_ScriptDir%\jetbrains.ahk

; --------------------------------------------------------------
; Typora Specificications
; --------------------------------------------------------------
#Include %A_ScriptDir%\typora.ahk

; --------------------------------------------------------------
; IM app (WeChat, WeCom, Teams) Specificications
; --------------------------------------------------------------
#Include %A_ScriptDir%\im.ahk

; --------------------------------------------------------------
; Windows Terminal Specificications
; --------------------------------------------------------------
#Include %A_ScriptDir%\windows-terminal.ahk
