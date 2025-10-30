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
            case Logger.INFO:  levelName := "INFO "
            case Logger.WARN:  levelName := "WARN "
            case Logger.ERROR: levelName := "ERROR"
            default:           levelName := "INFO "
        }

        ; Format module name
        moduleStr := module ? "[" module "] " : ""

        ; Format timestamp
        timestamp := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")

        ; Build log line
        logLine := timestamp " [" levelName "] " moduleStr message "`n"

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
}
