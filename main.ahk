;-----------------------------------------
; macOS Keyboard to Windows Key Mappings
;=========================================

; --------------------------------------------------------------
; NOTES
; --------------------------------------------------------------
; ! = ALT/options
; ^ = CTRL
; + = SHIFT
; # = WIN/⌘
;
; Debug action snippet: MsgBox You pressed Control-A while Notepad is active.

;#InstallKeybdHook
#SingleInstance force
SetTitleMatchMode 2
SendMode Input

; --------------------------------------------------------------
; Mac-like screenshots in Windows (requires Windows 10 Snip & Sketch)
; --------------------------------------------------------------
; Capture entire screen with ⌘/WIN + SHIFT + 3
;#+3::send #{PrintScreen}

; Capture portion of the screen with ⌘/WIN + SHIFT + 4
;#+4::#+s

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
;Lwin & Left::Send !{Left}
;Lwin & Right::Send !{Right}

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
#Include D:\Projects\AutoHotkeyProjects\macos-to-windows-key-mappings\macos-common.ahk

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

; --------------------------------------------------------------
; Google Chrome Specificications
; --------------------------------------------------------------
#Include D:\Projects\AutoHotkeyProjects\macos-to-windows-key-mappings\google-chrome.ahk

; --------------------------------------------------------------
; JetBrains Specificications
; This mappings also work with Visual Studio Code with the plugin "IntelliJ IDEA Keybindings"
; --------------------------------------------------------------
#Include D:\Projects\AutoHotkeyProjects\macos-to-windows-key-mappings\jetbrains.ahk

; --------------------------------------------------------------
; Typora Specificications
; --------------------------------------------------------------
#Include D:\Projects\AutoHotkeyProjects\macos-to-windows-key-mappings\typora.ahk

; --------------------------------------------------------------
; IM app (WeChat, WeCom, Teams) Specificications
; --------------------------------------------------------------
#Include D:\Projects\AutoHotkeyProjects\macos-to-windows-key-mappings\im.ahk
