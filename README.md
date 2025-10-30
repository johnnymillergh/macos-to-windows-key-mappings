# macOS to Windows Key Mappings

[AutoHotkey](https://www.autohotkey.com/) script `macOS Keymap.ahk` is the entrance of the program, which maps macOS keyboard shortcuts to Windows platform. Here are the main features:

- Based on AutoHotkey - [![](https://img.shields.io/badge/AutoHotKey-v2.0.10-informational?style=flat&logo=autohotkey&logoColor=white&color=2bbc8a)](https://github.com/AutoHotkey/AutoHotkey/releases/tag/v2.0.10).
- Common text or file editing keyboard shortcuts.
- JetBrains keyboard shortcuts (also works with Visual Studio Code's plugin `IntelliJ IDEA Keybindings`).
- Typora, Notion, and Obsidian keyboard shortcuts.
- Google Chrome keyboard shortcuts with **automatic full screen detection**.
- The keyboard shortcuts for instant message apps like Microsoft Teams, WeChat, Slack, Lark, DingTalk.
- Windows Terminal keyboard shortcuts.
- Postman keyboard shortcuts.
- DaVinci Resolve keyboard shortcuts.
- **Built-in logging system** for debugging and monitoring.
- And much more Windows apps to be supported.

This repository is based on the former gist [`johnnymillergh/macOS Keyboard to Windows Key Mappings.ahk`](https://gist.github.com/johnnymillergh/7df327476e1953e233827d88c823bfc8).

## Usage

1. Install [AutoHotKey](https://www.autohotkey.com/) on Windows PC.

2. Clone or download this project.

   ```sh
   $ git clone https://github.com/johnnymillergh/macos-to-windows-key-mappings.git -b main
   ```

3. Double click on `macOS Keymap.ahk` file to run.

## Auto Start after Windows Startup

Place `macOS Keymap.ahk` file (or make a shortcut) at one of these options:

- For all users, `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup`
- For current user,  `C:\Users\<USERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`

## Special Features

### Chrome Full Screen Detection

The script automatically detects when Chrome enters full screen mode (e.g., watching videos) and triggers **Lossless Scaling** by sending `Ctrl+Alt+S`. This feature:

- Monitors Chrome window size every 2 seconds (only when Chrome is active)
- Detects full screen from any trigger: keyboard shortcuts (F11, F), mouse clicks, or JavaScript
- Thread-safe implementation prevents duplicate triggers
- Automatically resets when exiting full screen

**To disable this feature**, comment out line 45 in `module/google-chrome.ahk`:
```autohotkey
; SetTimer(CheckChromeFullScreen, 2000)
```

### Logging and Debugging

The project includes a comprehensive logging system (`module/logger.ahk`) for debugging and monitoring:

**Log file location**: `app.log` (in the script directory)

**Features**:
- 4 log levels: DEBUG, INFO, WARN, ERROR
- Automatic log rotation (when file exceeds 10MB)
- PID and Thread name/ID logging
- Module tagging for organized logs

**Enable debug logging** (add to `macOS Keymap.ahk` after line 95):
```autohotkey
Logger.SetLevel(Logger.DEBUG)    ; Show all debug messages
Logger.EnablePID()                ; Include process ID
Logger.EnableThreadID()           ; Include thread name/ID
```

**View logs in real-time**:
```powershell
Get-Content app.log -Wait -Tail 20
```

## [Uninstall Windows Game Bar](https://www.reddit.com/r/WindowsHelp/comments/108ngxr/properly_uninstalling_xbox_gamebar_and_resolve/)

[How do I uninstall the Xbox Game Bar?](https://superuser.com/questions/1782270/how-do-i-uninstall-the-xbox-game-bar)

The shortcut `⌘ + g` for Chrome to jump to the next match is conflicting with Windows Game Bar.

1. To uninstall it open a powershell as administrator and uninstall it with the following command:
   ```powershell
   $ Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage
   ```

2. Disable the game recorder software:

   ```powershell
   $ reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR /f /t REG_DWORD /v "AppCaptureEnabled" /d 0
   $ reg add HKEY_CURRENT_USER\System\GameConfigStore /f /t REG_DWORD /v "GameDVR_Enabled" /d 0
   ```

## Project Structure

The project uses a modular architecture for easy maintenance and extensibility:

```
macos-to-windows-key-mappings/
├── macOS Keymap.ahk          # Main entry point
├── module/                   # Application-specific modules
│   ├── logger.ahk           # Logging system (utilities)
│   ├── macos-common.ahk     # Universal macOS shortcuts
│   ├── google-chrome.ahk    # Chrome shortcuts + full screen detection
│   ├── jetbrains.ahk        # JetBrains IDEs + VS Code
│   ├── im.ahk               # Instant messaging apps
│   ├── notion.ahk           # Notion app
│   ├── obsidian.ahk         # Obsidian app
│   ├── typora.ahk           # Typora markdown editor
│   ├── terminal.ahk         # Windows Terminal
│   ├── postman.ahk          # Postman API client
│   ├── davinci-resolve.ahk  # DaVinci Resolve video editor
│   └── windows.ahk          # Windows-specific shortcuts
├── CLAUDE.md                # Development guide for AI assistants
└── README.md                # This file
```

**Adding support for new applications**:
1. Create a new `.ahk` file in the `module/` directory
2. Use `#HotIf WinActive("ahk_exe yourapp.exe")` to scope shortcuts
3. Define key mappings: `#<key>::Send("^<key>")`
4. Include the module in `macOS Keymap.ahk`

See `module/logger-example.ahk` for logging usage examples.

## Credits

The [AutoHotKey v1 to v2 conversion](https://github.com/johnnymillergh/macos-to-windows-key-mappings/commit/f79de202bc04400bf657df58763cec66ab482bac) was implemented with [mmikeww/AHK-v2-script-converter](https://github.com/mmikeww/AHK-v2-script-converter).

## License

[Apache License](https://github.com/johnnymillergh/macos-to-windows-key-mappings/blob/main/LICENSE) © Johnny Miller

2023 - Present
