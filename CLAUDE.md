# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an **AutoHotKey v2.0.10+** project that maps macOS keyboard shortcuts to Windows. It provides a modular, extensible system for remapping keyboard shortcuts across multiple applications with automatic context detection.

## Architecture

The project uses a **modular architecture** with the following components:

### Core Files

- **macOS Keymap.ahk** - Main entry point that includes all modules, configures AutoHotKey environment, and initializes the logging system
- **module/lib/logger.ahk** - Comprehensive logging system with 4 levels (DEBUG/INFO/WARN/ERROR), PID/thread tracking, and automatic log rotation (10MB threshold)
- **module/lib/profiler.ahk** - Performance profiling utilities for measuring function execution time

### Application Modules

Each application has its own module in the `module/` directory:

- **macos-common.ahk** - Universal macOS shortcuts (Cmd+S, Cmd+C, Cmd+V, etc.)
- **google-chrome.ahk** - Chrome shortcuts + full screen detection integration
- **jetbrains.ahk** - JetBrains IDEs (IntelliJ IDEA, PyCharm, WebStorm, etc.) + VS Code with IntelliJ keybindings plugin
- **im.ahk** - Instant messaging apps (Teams, WeChat, Slack, Lark, DingTalk)
- **notion.ahk** - Notion app shortcuts
- **typora.ahk** - Typora markdown editor
- **obsidian.ahk** - Obsidian markdown editor
- **terminal.ahk** - Windows Terminal
- **postman.ahk** - Postman API client
- **davinci-resolve.ahk** - DaVinci Resolve video editor
- **lossless-scaling.ahk** - Full screen detection module with automatic Lossless Scaling trigger
- **windows.ahk** - Windows-specific shortcuts

### Key Mapping Convention

- `#` = Win/Cmd key (⌘)
- `!` = Alt/Option key (⌥)
- `^` = Ctrl key (⌃)
- `+` = Shift key (⇧)

### Application Scoping

Shortcuts are scoped to specific applications using:
```autohotkey
#HotIf WinActive("ahk_exe yourapp.exe")
; Shortcuts here
#HotIf
```

### Chrome Full Screen Detection

The **lossless-scaling.ahk** module includes sophisticated full screen detection that:
- Monitors Chrome/Edge window size every 2 seconds (only when active)
- Detects full screen from multiple triggers (F11, JavaScript, mouse clicks)
- Prevents duplicate triggers with thread-safe implementation
- Triggers Lossless Scaling via `Ctrl+Alt+S` when entering full screen
- Automatically resets when exiting full screen
- Uses a `titleBlockList` to filter out certain streaming services (Netflix, Disney+, Paramount+, Tubi)

**To disable**: Comment out line 45 in `module/google-chrome.ahk`:
```autohotkey
; SetTimer(CheckChromeFullScreen, 2000)
```

### Logging System

The `Logger` class (module/lib/logger.ahk) provides:
- 4 log levels: DEBUG (0), INFO (1), WARN (2), ERROR (3)
- Log file: `app.log` (auto-rotates at 10MB)
- Optional PID and Thread ID/Name inclusion
- Module-based tagging for organized logs

**Enable debug logging** (add to macOS Keymap.ahk after line 95):
```autohotkey
Logger.SetLevel(Logger.DEBUG)
Logger.EnablePID()
Logger.EnableThreadID()
```

**View logs in real-time**:
```powershell
Get-Content app.log -Wait -Tail 20
```

## Development

### Running the Script

1. Install [AutoHotKey v2.0.10+](https://www.autohotkey.com/)
2. Double-click `macOS Keymap.ahk` to run

### Auto-start on Windows Startup

Place `macOS Keymap.ahk` (or a shortcut) in:
- All users: `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup`
- Current user: `C:\Users\<USERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`

### Adding New Application Support

1. Create a new `.ahk` file in `module/` directory
2. Add `#Include` statement in `macOS Keymap.ahk`
3. Scope shortcuts with `#HotIf WinActive("ahk_exe yourapp.exe")`
4. Define mappings: `#<key>::Send("^<key>")`
5. Add logging: `Logger.Info("Module loaded", "ModuleName")`

Example structure:
```autohotkey
#Include "%A_ScriptDir%\module\lib\logger.ahk"

#HotIf WinActive("ahk_exe yourapp.exe")
; Shortcuts here
#HotIf

Logger.Info("YourApp script loaded", "YourApp")
```

### Profiling

The Profiler class can measure function execution time:

```autohotkey
#Include "%A_ScriptDir%\module\lib\profiler.ahk"

; Profile a single execution
result := Profile(MyFunction, [arg1, arg2])
MsgBox("Executed in " result.ElapsedMs " ms")

; Profile inline with lambda
result := Profile(() => Send("Hello"))

; Profile a code block
timer := ProfileStart()
; ... your code here ...
elapsed := ProfileEnd(timer)
MsgBox("Block executed in " elapsed.ElapsedMsHighRes " ms")
```

### Xbox Game Bar Conflict

`Cmd+G` (Chrome find next match) conflicts with Windows Game Bar. To fix:
```powershell
# Uninstall Xbox Game Bar
Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage

# Disable game recorder
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR /f /t REG_DWORD /v "AppCaptureEnabled" /d 0
reg add HKEY_CURRENT_USER\System\GameConfigStore /f /t REG_DWORD /v "GameDVR_Enabled" /d 0
```

## Important Notes

- This is an **interpreted AutoHotKey project** - no build process required
- No tests or linting configuration exists
- The `.history/` directory contains version history snapshots - don't modify
- The `.exe` file is a compiled version of the AHK script
- Key remapping applies globally unless scoped with `#HotIf`
- All modules log their loading status at initialization

## Common Issues

- **Shortcuts not working**: Check the target application is running and the `WinActive` condition matches
- **Conflicting shortcuts**: Windows or other software may intercept the key combination
- **Log file growth**: Automatically rotates at 10MB, but can be manually cleared with `Logger.Clear()`
- **Chrome full screen detection**: Only runs when Chrome is active, every 2 seconds

## Related Documentation

- README.md - General project documentation and usage instructions
- module/lib/logger-example.ahk - Comprehensive logging usage examples
- module/lib/profiler-examples.ahk - Profiling usage examples