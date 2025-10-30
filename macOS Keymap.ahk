#Requires AutoHotkey >=2.0.10

; Relauch as admin if not already running as admin
; https://www.autohotkey.com/docs/v2/lib/Run.htm#RunAs
full_command_line := DllCall("GetCommandLine", "str")

; if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
; {
;     try
;     {
;         if A_IsCompiled
;             Run '*RunAs "' A_ScriptFullPath '" /restart'
;         else
;             Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
;     }
;     ExitApp
; }

;MsgBox "A_IsAdmin: " A_IsAdmin "`nCommand line: " full_command_line
TrayTip("macOS keymap is running with AutoHotKey " A_AhkVersion "`nA_IsAdmin: " A_IsAdmin "`nCommand line: " full_command_line, "macOS Keymap")

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

InstallKeybdHook()
#SingleInstance force
SetTitleMatchMode(2)
SendMode("Input")

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
Lwin & Left::Send("!{Left}")
Lwin & Right::Send("!{Right}")

; Eject Key
;F20::SendInput("{Insert}") ; F20 doesn't show up on AHK anymore, see #3

; F13-15, standard Windows mapping
;F13::SendInput {PrintScreen}
;F14::SendInput {ScrollLock}
;F15::SendInput {Pause}

;F16-19 custom app launchers, see http://www.autohotkey.com/docs/Tutorial.htm for usage info
;F16::Run https://twitter.com
;F17::Run https://linkedin.com
;F18::Run https://www.reddit.com
;F19::Run https://facebook.com

; Control the Mouse with the Keyboard with WASD
; https://www.autohotkey.com/boards/viewtopic.php?t=24588
; https://www.autohotkey.com/boards/viewtopic.php?t=67139
; MOUSE_OFFSET := 15
; !w::MouseMove 0, (MOUSE_OFFSET * -1), 0, "R"
; !s::MouseMove 0, MOUSE_OFFSET, 0, "R"
; !a::MouseMove (MOUSE_OFFSET * -1), 0, 0, "R"
; !d::MouseMove MOUSE_OFFSET, 0, 0, "R"
; !+w::MouseMove 0, (MOUSE_OFFSET * 4 * -1), 50, "R"
; !+s::MouseMove 0, MOUSE_OFFSET * 4, 50, "R"
; !+a::MouseMove (MOUSE_OFFSET * 4 * -1), 0, 50, "R"
; !+d::MouseMove MOUSE_OFFSET * 4, 0, 50, "R"

!r::Click "Left"
!t::Click "Right"

; --------------------------------------------------------------
; Include .ahk file
; --------------------------------------------------------------
#Include "%A_ScriptDir%\module\logger.ahk"
#Include "%A_ScriptDir%\module\macos-common.ahk"
#Include "%A_ScriptDir%\module\windows.ahk"
#Include "%A_ScriptDir%\module\google-chrome.ahk"
#Include "%A_ScriptDir%\module\jetbrains.ahk"
#Include "%A_ScriptDir%\module\notion.ahk"
#Include "%A_ScriptDir%\module\obsidian.ahk"
#Include "%A_ScriptDir%\module\typora.ahk"
#Include "%A_ScriptDir%\module\im.ahk"
#Include "%A_ScriptDir%\module\terminal.ahk"
#Include "%A_ScriptDir%\module\postman.ahk"
#Include "%A_ScriptDir%\module\davinci-resolve.ahk"
