; --------------------------------------------------------------
; Logger Module - Usage Examples
; --------------------------------------------------------------

#Requires AutoHotkey >=2.0.10
#Include "%A_ScriptDir%\logger.ahk"

; Example 1: Basic logging
Logger.Info("Application started")
Logger.Warn("This is a warning message")
Logger.Error("Something went wrong!")

; Example 2: Logging with module name
Logger.Info("User logged in successfully", "Auth")
Logger.Debug("Processing user data", "Auth")

; Example 3: Change log level to see debug messages
Logger.SetLevel(Logger.DEBUG)  ; Now DEBUG messages will show
Logger.Debug("This debug message will now appear")

; Example 4: Set custom log file
Logger.SetLogFile(A_ScriptDir "\custom.log")
Logger.Info("This goes to custom.log")

; Example 5: Temporarily disable logging
Logger.Disable()
Logger.Info("This won't be logged")
Logger.Enable()
Logger.Info("This will be logged")

; Example 6: Enable PID and Thread ID/Name logging
Logger.EnablePID()
Logger.EnableThreadID()

; Set a custom name for the current thread (optional, for better readability)
Logger.SetCurrentThreadName("MainThread")
Logger.Info("This log includes PID and Thread Name")

; Example 7: Disable PID/Thread ID logging
Logger.DisablePID()
Logger.DisableThreadID()
Logger.Info("Back to normal logging")

; Example 8: Clear log file
; Logger.Clear()  ; Uncomment to delete the log file

; Example 9: Log levels in order of severity
; DEBUG (0) - Detailed debugging information
; INFO  (1) - General informational messages (default level)
; WARN  (2) - Warning messages
; ERROR (3) - Error messages

; Example 10: Logging in a function
MyFunction() {
    Logger.Info("MyFunction called", "App")

    try {
        ; Do something
        result := 1 / 0  ; This will cause an error
    } catch as err {
        Logger.Error("Division by zero: " err.Message, "App")
    }
}

MyFunction()

MsgBox("Check the log file at:`n" Logger.logFile)
