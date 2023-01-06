# macOS to Windows Key Mappings

[AutoHotkey](https://www.autohotkey.com/) script `main.ahk` is the entrance of the program, which maps macOS keyboard shortcuts to Windows platform. Here is the main functions including:

- Based on the latest AutoKotkey - [![](https://img.shields.io/badge/AutoHotKey-v2.0.2-informational?style=flat&logo=autohotkey&logoColor=white&color=2bbc8a)](https://github.com/AutoHotkey/AutoHotkey/releases/tag/v2.0.2).
- Common text or file editing keyboard shortcuts.
- JetBrains keyboard shortcuts (also works with Visual Studio Code's plugin `IntelliJ IDEA Keybindings`).
- Typora keyboard shortcuts.
- Google Chrome keyboard shortcuts.
- The keyboard shortcuts for instant message apps like Microsoft Teams, WeChat, Slack, Lark.
- Windows Terminal keyboard shortcuts.
- And much more Windows apps to be supported.

This repository is based on former gist [`johnnymillergh/macOS Keyboard to Windows Key Mappings.ahk`](https://gist.github.com/johnnymillergh/7df327476e1953e233827d88c823bfc8).

## Usage

1. Install [AutoHotKey](https://www.autohotkey.com/) on Windows PC.

2. Clone or download this project.

   ```sh
   $ git clone https://github.com/johnnymillergh/macos-to-windows-key-mappings.git
   ```

3. Double click on `main.ahk` file to run.

## Auto Start after Windows Startup

Place `main.ahk` file (or make a shortcut) at `C:\Users\<USERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`
