#Include "%A_ScriptDir%\module\logger.ahk"

; --------------------------------------------------------------
; Google Chrome Specifications
; --------------------------------------------------------------

; Full screen detection state
global chromeWasFullScreen := false

; Simple, reliable full screen detection - only runs when Chrome is active
CheckChromeFullScreen() {
    global chromeWasFullScreen

    ; Prevent race conditions - make this function thread-safe
    Critical

    ; Only check if Chrome is the active window
    if !WinActive("ahk_exe chrome.exe")
        return
    ; Get Chrome window position and size
    WinGetPos(&winX, &winY, &winWidth, &winHeight, "A")

    ; Get screen dimensions
    MonitorGet(MonitorGetPrimary(), &monLeft, &monTop, &monRight, &monBottom)
    screenWidth := monRight - monLeft
    screenHeight := monBottom - monTop

    ; Check if window covers entire screen (full screen mode)
    isFullScreen := (winX <= 0 && winY <= 0 && winWidth >= screenWidth && winHeight >= screenHeight)
    ; Log window state (DEBUG level - only shows if Logger.SetLevel(Logger.DEBUG) is called)
    Logger.Debug("Window: " winWidth "x" winHeight " at (" winX "," winY ") | Screen: " screenWidth "x" screenHeight " | FullScreen: " isFullScreen " | Was: " chromeWasFullScreen,
        "Chrome")

    ; Trigger only on transition to full screen (not continuously)
    if (isFullScreen && !chromeWasFullScreen) {
        Logger.Info("Full screen detected - triggering Lossless Scaling (Ctrl+Alt+S)", "Chrome")
        Send("^!s")  ; Send Ctrl + Alt + S to activate Lossless Scaling
        chromeWasFullScreen := true
    } else if (!isFullScreen && chromeWasFullScreen) {
        Logger.Info("Exited full screen", "Chrome")
        chromeWasFullScreen := false
    }
}

; Run check every 2000ms - only processes when Chrome is active
SetTimer(CheckChromeFullScreen, 2000)

#HotIf WinActive("ahk_exe chrome.exe")

; Show Web Developer Tools with ⌘ + alt + i
#!i:: Send("{F12}")

; Select an element with ⌘ + shift + c
#+c:: Send("^+c")

; Show source code with ⌘ + alt + u
#!u:: Send("^u")

; Restore web page with ⌘ + shift + t
#+t:: Send("^+t")

; Select an element in the page and inspect it with alt + shift + c
!+c:: Send("^+c")

; Switch to tab 1 with ⌘ + 1
#1:: Send("^1")

; Switch to tab 2 with ⌘ + 2
#2:: Send("^2")

; Switch to tab 3 with ⌘ + 3
#3:: Send("^3")

; Switch to tab 4 with ⌘ + 4
#4:: Send("^4")

; Switch to tab 5 with ⌘ + 5
#5:: Send("^5")

; Switch to tab 6 with ⌘ + 6
#6:: Send("^6")

; Print the current page with ⌘ + p
#p:: Send("^p")

; Chrome extension: https://github.com/alyssaxuu/omni with ⌘ + shift + k
#+k:: Send("^+k")

; Open an incognito window with ⌘ + Shift + n
#+n:: Send("^+n")

; Open the Downloads page in a new tab with ⌘ + shift + j
#+j:: Send("^j")

; Jump to the next match to your Find Bar search with ⌘ + g
#g:: Send("^g")

; Jump to the previous match to your Find Bar search with ⌘ + shift + g
#+g:: Send("^+g")
#HotIf

Logger.Info("Google Chrome script loaded: " A_ScriptName, "Chrome")
