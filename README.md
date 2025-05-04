# macOS to Windows Key Mappings

[AutoHotkey](https://www.autohotkey.com/) script `macOS Keymap.ahk` is the entrance of the program, which maps macOS keyboard shortcuts to Windows platform. Here is the main functions including:

- Based on the AutoKotkey - [![](https://img.shields.io/badge/AutoHotKey-v2.0.10-informational?style=flat&logo=autohotkey&logoColor=white&color=2bbc8a)](https://github.com/AutoHotkey/AutoHotkey/releases/tag/v2.0.10).
- Common text or file editing keyboard shortcuts.
- JetBrains keyboard shortcuts (also works with Visual Studio Code's plugin `IntelliJ IDEA Keybindings`).
- Typora keyboard shortcuts.
- Google Chrome keyboard shortcuts.
- The keyboard shortcuts for instant message apps like Microsoft Teams, WeChat, Slack, Lark.
- Windows Terminal keyboard shortcuts.
- DaVinci Resolve keyboard shortcuts.
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

Place `main.ahk` file (or make a shortcut) at one of these options:

- For all users, `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup`
- For current user,  `C:\Users\<USERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`

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

## Credits

The [AutoHotKey v1 to v2 conversion](https://github.com/johnnymillergh/macos-to-windows-key-mappings/commit/f79de202bc04400bf657df58763cec66ab482bac) was implemented with [mmikeww/AHK-v2-script-converter](https://github.com/mmikeww/AHK-v2-script-converter).

## License

[Apache License](https://github.com/johnnymillergh/macos-to-windows-key-mappings/blob/main/LICENSE) © Johnny Miller

2023 - Present
