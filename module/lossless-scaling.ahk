#Include "%A_ScriptDir%\module\lib\logger.ahk"

; Full screen detection state
global isLosslessScalingActive := false
global lastLosslessScalingToggleTick := 0
global LOSSLESS_SCALING_TOGGLE_COOLDOWN_MS := 1500
global monitoredApps := ["chrome.exe", "msedge.exe"]
global titleBlockList := ["Netflix", "Disney+", "Paramount+", "Tubi"]

/**
 * Check if a window title should skip Lossless Scaling.
 * @param windowTitle Active window title
 * @return {Boolean} 1 (true) if title is blocked, 0 (false) otherwise
 */
IsWindowTitleBlocked(windowTitle) {
    global titleBlockList

    for blockedTitle in titleBlockList {
        if InStr(windowTitle, blockedTitle) {
            return true
        }
    }

    return false
}

/**
 * Toggle Lossless Scaling toward the desired active state with debounce protection.
 * @param desiredActiveState Boolean desired Lossless Scaling state
 * @param reason Human-readable transition reason for logs
 * @param activeApp Optional active app executable name
 * @param windowTitle Optional active window title
 * @return {Boolean} 1 (true) if state is already correct or toggle was sent, 0 if skipped by cooldown
 */
ToggleLosslessScaling(desiredActiveState, reason, activeApp := "", windowTitle := "") {
    global isLosslessScalingActive
    global lastLosslessScalingToggleTick
    global LOSSLESS_SCALING_TOGGLE_COOLDOWN_MS

    desiredStateName := desiredActiveState ? "active" : "inactive"
    if (isLosslessScalingActive == desiredActiveState) {
        Logger.Debug("Lossless Scaling already " desiredStateName " - " reason, "Lossless Scaling")
        return true
    }

    elapsedSinceLastToggle := A_TickCount - lastLosslessScalingToggleTick
    if (lastLosslessScalingToggleTick > 0 && elapsedSinceLastToggle < LOSSLESS_SCALING_TOGGLE_COOLDOWN_MS) {
        Logger.Debug("Lossless Scaling toggle skipped due to cooldown (" elapsedSinceLastToggle " ms / "
            LOSSLESS_SCALING_TOGGLE_COOLDOWN_MS " ms) - " reason, "Lossless Scaling")
        return false
    }

    logMessage := (desiredActiveState ? "Activating" : "Deactivating") " Lossless Scaling - " reason
    if (activeApp != "") {
        logMessage .= ", App: " activeApp
    }
    if (windowTitle != "") {
        logMessage .= " | Title: " windowTitle
    }

    Logger.Info(logMessage, "Lossless Scaling")
    Send("^!+#{s}")
    lastLosslessScalingToggleTick := A_TickCount
    isLosslessScalingActive := desiredActiveState
    return true
}

/**
 * Get the full monitor bounds for the monitor containing the window center.
 * Falls back to the primary monitor if no monitor contains the center point.
 * @param x Window left coordinate
 * @param y Window top coordinate
 * @param w Window width
 * @param h Window height
 * @return {Object} Monitor bounds with Left, Top, Right, Bottom properties
 */
GetMonitorBoundsForWindow(x, y, w, h) {
    centerX := x + (w / 2)
    centerY := y + (h / 2)
    monitorCount := MonitorGetCount()

    Loop monitorCount {
        MonitorGet(A_Index, &left, &top, &right, &bottom)
        if (centerX >= left && centerX <= right && centerY >= top && centerY <= bottom) {
            return { Left: left, Top: top, Right: right, Bottom: bottom }
        }
    }

    MonitorGet(MonitorGetPrimary(), &left, &top, &right, &bottom)
    return { Left: left, Top: top, Right: right, Bottom: bottom }
}

/**
 * Check if current window is in full screen mode by examining window styles and monitor coverage.
 * @return {Boolean} 1 (true) if window is in full screen mode, 0 (false) otherwise
 */
IsWindowFullscreen() {
    activeWinID := WinGetID("A")
    if !activeWinID {
        return false
    }

    ; Check 1: Window style (no titlebar)
    style := WinGetStyle("ahk_id " activeWinID)
    hasNoCaption := !(style & 0xC00000)

    ; Check 2: Window covers the monitor that contains the active window center.
    WinGetPos(&x, &y, &w, &h, "ahk_id " activeWinID)
    monitorBounds := GetMonitorBoundsForWindow(x, y, w, h)
    tolerance := 8
    coversScreen := (x <= monitorBounds.Left + tolerance && y <= monitorBounds.Top + tolerance && x + w >= monitorBounds.Right - tolerance && y + h >= monitorBounds.Bottom - tolerance)

    ; True fullscreen = both conditions met
    return hasNoCaption && coversScreen
}

WindowFullScreenMonitor() {
    ; Prevent race conditions - make this function thread-safe
    Critical

    global monitoredApps
    global isLosslessScalingActive

    ; Check if any monitored app is active
    activeApp := ""
    for exeName in monitoredApps {
        if WinActive("ahk_exe " exeName) {
            activeApp := exeName
            break
        }
    }

    if (activeApp == "") {
        if (isLosslessScalingActive) {
            ToggleLosslessScaling(false, "monitored app no longer active")
        }

        return
    }

    windowTitle := WinGetTitle("A")

    if (IsWindowTitleBlocked(windowTitle)) {
        ToggleLosslessScaling(false, "blocked title", activeApp, windowTitle)
        return
    }

    isFullScreen := IsWindowFullscreen()

    Logger.Debug("FullScreen: " isFullScreen " | LosslessScalingActive: " isLosslessScalingActive, "Lossless Scaling")

    if (isFullScreen) {
        ToggleLosslessScaling(true, "full screen detected", activeApp, windowTitle)
    } else {
        ToggleLosslessScaling(false, "exited full screen", activeApp, windowTitle)
    }
}

; Only enable detection if Lossless Scaling is installed (Steam Start Menu shortcut).
; #Include is load-time, so the gate lives here on the timer - the module's only active behavior.
losslessScalingShortcut := A_AppData "\Microsoft\Windows\Start Menu\Programs\Steam\Lossless Scaling.url"
if FileExist(losslessScalingShortcut) {
    SetTimer(WindowFullScreenMonitor, 2000)  ; Run check every 2000ms
    Logger.Info("Lossless Scaling script loaded: " A_ScriptName, "Lossless Scaling")
} else {
    Logger.Info("Lossless Scaling not installed (" losslessScalingShortcut " missing) - detection disabled", "Lossless Scaling")
}
