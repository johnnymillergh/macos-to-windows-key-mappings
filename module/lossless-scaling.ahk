#Include "%A_ScriptDir%\module\lib\logger.ahk"
#Include "%A_ScriptDir%\module\lib\profiler.ahk"

; Full screen detection state
global wasFullScreen := false
global monitoredApps := ["chrome.exe", "msedge.exe"]

/**
 * Check if current window is in full screen mode by examining window styles
 * @return {Boolean} 1 (true) if window is in full screen mode, 0 (false) otherwise
 */
IsWindowFullscreen() {
    timer := ProfileStart()
    activeWinID := WinGetID("A")
    if !activeWinID {
        elapsed := ProfileEnd(timer)
        Logger.Debug("IsWindowFullscreen (early return): " Format("{:.3f}", elapsed.ElapsedMsHighRes) " ms", "Lossless Scaling")
        return false
    }

    ; Check 1: Window style (no titlebar)
    style := WinGetStyle("ahk_id " activeWinID)
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
    WinGetPos(&x, &y, &w, &h, "ahk_id " activeWinID)
    MonitorGetWorkArea(MonitorGetPrimary(), &left, &top, &right, &bottom)
    coversScreen := (x <= 0 && y <= 0 && w >= right && h >= bottom)

    ; True fullscreen = both conditions met
    result := hasNoCaption && coversScreen

    elapsed := ProfileEnd(timer)
    Logger.Debug("IsWindowFullscreen: " Format("{:.3f}", elapsed.ElapsedMsHighRes) " ms (result: " result ")", "Lossless Scaling")
    return result
}

WindowFullScreenMonitor() {
    timer := ProfileStart()

    ; Prevent race conditions - make this function thread-safe
    Critical
    
    global monitoredApps
    global wasFullScreen
    
    ; Check if any monitored app is active
    activeApp := ""
    for exeName in monitoredApps {
        if WinActive("ahk_exe " exeName) {
            activeApp := exeName
            break
        }
    }
    
    if (activeApp == "") {
        elapsed := ProfileEnd(timer)
        Logger.Debug("WindowFullScreenMonitor (no monitored app active): " Format("{:.3f}", elapsed.ElapsedMsHighRes) " ms", "Lossless Scaling")
        return
    }

    windowTitle := WinGetTitle("A")
    isFullScreen := IsWindowFullscreen()

    Logger.Debug("FullScreen: " isFullScreen " | Was: " wasFullScreen, "Lossless Scaling")

    if (isFullScreen && !wasFullScreen) {
        Logger.Info("Full screen detected - triggering Lossless Scaling, App: " activeApp " | Title: " windowTitle, "Lossless Scaling")
        ; Send Ctrl + Alt + S to activate Lossless Scaling
        Send("^!s")
        wasFullScreen := true
    } else if (!isFullScreen && wasFullScreen) {
        Logger.Info("Exited full screen, deactivate Lossless Scaling, App: " activeApp " | Title: " windowTitle, "Lossless Scaling")
        ; Send Ctrl + Alt + S to de-activate Lossless Scaling
        Send("^!s")
        wasFullScreen := false
    }

    elapsed := ProfileEnd(timer)
    Logger.Debug("WindowFullScreenMonitor total: " Format("{:.3f}", elapsed.ElapsedMsHighRes) " ms", "Lossless Scaling")
}

; Run check every 2000ms
SetTimer(WindowFullScreenMonitor, 2000)

Logger.Info("Lossless Scaling script loaded: " A_ScriptName, "Lossless Scaling")
