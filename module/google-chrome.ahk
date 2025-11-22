#Include "%A_ScriptDir%\module\lib\logger.ahk"

; --------------------------------------------------------------
; Google Chrome Specifications
; --------------------------------------------------------------

; Full screen detection state
global chromeWasFullScreen := false

/**
* Check if Chrome is in full screen mode by examining window styles
* @return {Boolean} 1 (true) if Chrome is in full screen mode, 0 (false) otherwise
*/
IsChromeFullscreen() {
    if !WinExist("ahk_exe chrome.exe")
        return false

    ; Check 1: Window style (no titlebar)
    style := WinGetStyle("ahk_exe chrome.exe")
    hasNoCaption := !(style & 0xC00000)

    /*
    Check 2: Check Position Covers Screen

    What it does:

    - Gets Chrome's position and size:
        - x, y = top-left corner coordinates
        - w, h = width and height
    - Gets the monitor's work area:
        - MonitorGetPrimary() = gets the main monitor
        - MonitorGetWorkArea() = gets usable screen space (excluding taskbar)
        - left, top, right, bottom = screen boundaries
    - Checks if window covers entire screen:
        - x <= 0 - window starts at or before left edge
        - y <= 0 - window starts at or before top edge
        - w >= right - width extends to or beyond right edge
        - h >= bottom - height extends to or beyond bottom edge
    */
    WinGetPos(&x, &y, &w, &h, "ahk_exe chrome.exe")
    MonitorGetWorkArea(MonitorGetPrimary(), &left, &top, &right, &bottom)
    coversScreen := (x <= 0 && y <= 0 && w >= right && h >= bottom)

    ; True fullscreen = both conditions met
    return hasNoCaption && coversScreen
}

CheckChromeFullScreen() {
    ; Prevent race conditions - make this function thread-safe
    Critical
    if !WinActive("ahk_exe chrome.exe")
        return
    chromeTitle := WinGetTitle("A")
    global chromeWasFullScreen
    isFullScreen := IsChromeFullscreen()
    Logger.Debug("FullScreen: " isFullScreen " | Was: " chromeWasFullScreen, "Chrome")
    if (isFullScreen && !chromeWasFullScreen) {
        Logger.Info("Full screen detected - triggering Lossless Scaling, Chrome title: " chromeTitle, "Chrome")
        ; Send Ctrl + Alt + S to activate Lossless Scaling
        Send("^!s")
        chromeWasFullScreen := true
    } else if (!isFullScreen && chromeWasFullScreen) {
        Logger.Info("Exited full screen, deactivate Lossless Scaling, Chrome title: " chromeTitle, "Chrome")
        ; Send Ctrl + Alt + S to de-activate Lossless Scaling
        Send("^!s")
        chromeWasFullScreen := false
    }
}

; Run check every 2000ms - only processes when Chrome is active
SetTimer(CheckChromeFullScreen, 500)

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
