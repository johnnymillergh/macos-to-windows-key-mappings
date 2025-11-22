; --------------------------------------------------------------
; Logger Module - Common logging functionality
; --------------------------------------------------------------

class Logger {
    ; Log levels (defined as static properties)
    static DEBUG => 0
    static INFO => 1
    static WARN => 2
    static ERROR => 3

    ; Current log level (set to INFO by default, change to DEBUG to see debug logs)
    static currentLevel := 1  ; INFO

    ; Log file path (default to script directory)
    static logFile := A_ScriptDir "\app.log"

    ; Enable/disable logging globally
    static enabled := true

    ; Maximum log file size in bytes (10MB default)
    static maxSize := 10485760

    ; Include PID and thread ID in logs
    static includePID := true
    static includeThreadID := true

    /**
     * Log a debug message
     * @param message The message to log
     * @param module Optional module name (e.g., "Chrome", "JetBrains")
     */
    static Debug(message, module := "") {
        Logger.Log(message, Logger.DEBUG, module)
    }

    /**
     * Log an info message
     * @param message The message to log
     * @param module Optional module name
     */
    static Info(message, module := "") {
        Logger.Log(message, Logger.INFO, module)
    }

    /**
     * Log a warning message
     * @param message The message to log
     * @param module Optional module name
     */
    static Warn(message, module := "") {
        Logger.Log(message, Logger.WARN, module)
    }

    /**
     * Log an error message
     * @param message The message to log
     * @param module Optional module name
     */
    static Error(message, module := "") {
        Logger.Log(message, Logger.ERROR, module)
    }

    /**
     * Core logging function
     * @param message The message to log
     * @param level Log level (DEBUG, INFO, WARN, ERROR)
     * @param module Optional module name
     */
    static Log(message, level := 1, module := "") {
        ; Check if logging is enabled and level is sufficient
        if (!Logger.enabled || level < Logger.currentLevel)
            return

        ; Check file size and rotate if needed
        Logger.RotateIfNeeded()

        ; Format level name
        levelName := ""
        switch level {
            case Logger.DEBUG: levelName := "DEBUG"
            case Logger.INFO: levelName := "INFO "
            case Logger.WARN: levelName := "WARN "
            case Logger.ERROR: levelName := "ERROR"
            default: levelName := "INFO "
        }

        ; Format module name
        moduleStr := module ? "[" module "] " : ""

        ; Format timestamp
        timestamp := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")

        ; Get PID if enabled
        pidStr := ""
        if (Logger.includePID) {
            pid := DllCall("GetCurrentProcessId")
            pidStr := "[PID:" pid "] "
        }

        ; Get Thread Name/ID if enabled
        threadStr := ""
        if (Logger.includeThreadID) {
            tid := DllCall("GetCurrentThreadId")
            threadName := Logger.GetThreadName(tid)
            if (threadName != "") {
                threadStr := "[Thread:" threadName "] "
            } else {
                threadStr := "[TID:" tid "] "
            }
        }

        ; Build log line
        logLine := timestamp " " pidStr threadStr "[" levelName "] " moduleStr message "`n"

        ; Write to file
        try {
            FileAppend(logLine, Logger.logFile)
        } catch as err {
            ; Silently fail if can't write to log
        }
    }

    /**
     * Rotate log file if it exceeds max size
     */
    static RotateIfNeeded() {
        try {
            if FileExist(Logger.logFile) {
                size := FileGetSize(Logger.logFile)
                if (size > Logger.maxSize) {
                    ; Rename old log file with timestamp
                    backupName := A_ScriptDir "\app-" FormatTime(A_Now, "yyyyMMdd-HHmmss") ".log"
                    FileMove(Logger.logFile, backupName)
                }
            }
        } catch {
            ; Ignore errors
        }
    }

    /**
     * Set custom log file path
     * @param filePath Full path to log file
     */
    static SetLogFile(filePath) {
        Logger.logFile := filePath
    }

    /**
     * Set log level
     * @param level Logger.DEBUG, Logger.INFO, Logger.WARN, or Logger.ERROR
     */
    static SetLevel(level) {
        Logger.currentLevel := level
    }

    /**
     * Enable logging
     */
    static Enable() {
        Logger.enabled := true
    }

    /**
     * Disable logging
     */
    static Disable() {
        Logger.enabled := false
    }

    /**
     * Clear the log file
     */
    static Clear() {
        try {
            if FileExist(Logger.logFile)
                FileDelete(Logger.logFile)
        } catch {
            ; Ignore errors
        }
    }

    /**
     * Enable PID logging
     */
    static EnablePID() {
        Logger.includePID := true
    }

    /**
     * Disable PID logging
     */
    static DisablePID() {
        Logger.includePID := false
    }

    /**
     * Enable Thread ID logging
     */
    static EnableThreadID() {
        Logger.includeThreadID := true
    }

    /**
     * Disable Thread ID logging
     */
    static DisableThreadID() {
        Logger.includeThreadID := false
    }

    /**
     * Get thread name using Windows API
     * @param tid Thread ID
     * @return Thread name if available, empty string otherwise
     */
    static GetThreadName(tid) {
        try {
            ; Open thread handle with QUERY_LIMITED_INFORMATION access (0x0800)
            hThread := DllCall("OpenThread", "UInt", 0x0800, "Int", 0, "UInt", tid, "Ptr")
            if (!hThread)
                return ""

            ; Try to get thread description (Windows 10 1607+)
            pDescription := 0
            result := DllCall("GetThreadDescription", "Ptr", hThread, "Ptr*", &pDescription, "UInt")

            threadName := ""
            if (result = 0 && pDescription) {  ; S_OK = 0
                ; Read the wide string from the pointer
                threadName := StrGet(pDescription, "UTF-16")
                ; Free the memory allocated by GetThreadDescription
                DllCall("LocalFree", "Ptr", pDescription)
            }

            ; Close thread handle
            DllCall("CloseHandle", "Ptr", hThread)

            return threadName
        } catch {
            return ""
        }
    }

    /**
     * Set current thread name (for better logging)
     * @param name Thread name to set
     */
    static SetCurrentThreadName(name) {
        try {
            tid := DllCall("GetCurrentThreadId")
            hThread := DllCall("OpenThread", "UInt", 0x0800, "Int", 0, "UInt", tid, "Ptr")
            if (!hThread)
                return

            ; Set thread description (Windows 10 1607+)
            DllCall("SetThreadDescription", "Ptr", hThread, "Str", name)
            DllCall("CloseHandle", "Ptr", hThread)
        } catch {
            ;
        }
    }
}
