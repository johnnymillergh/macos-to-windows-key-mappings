#Requires AutoHotkey v2.0
#Include "profiler.ahk"

; ============================================================
; Example 1: Profile a single function
; ============================================================

TestFunction1(n) {
    result := 0
    Loop n
        result += A_Index
    return result
}

Example1() {
    MsgBox("Example 1: Profile a single function")

    result := Profile(TestFunction1, [1000])

    MsgBox(
        "Result: " result.Result "`n"
        "Elapsed: " result.ElapsedMs " ms`n"
        "High-res: " result.ElapsedMsHighRes " ms"
    )
}

; ============================================================
; Example 2: Profile with statistics (multiple runs)
; ============================================================

Example2() {
    MsgBox("Example 2: Profile with statistics (100 iterations)")

    stats := ProfileStats(TestFunction1, [1000], 100)

    MsgBox(Profiler.FormatStats(stats))
}

; ============================================================
; Example 3: Profile inline code with lambda
; ============================================================

Example3() {
    MsgBox("Example 3: Profile inline code")

    result := Profile(() => (
        Sleep(10),
        WinGetTitle("A")
    ))

    MsgBox(
        "Window title: " result.Result "`n"
        "Time taken: " result.ElapsedMsHighRes " ms"
    )
}

; ============================================================
; Example 4: Manual profiling (code blocks)
; ============================================================

Example4() {
    MsgBox("Example 4: Manual profiling of code block")

    timer := ProfileStart()

    ; Your code here
    Loop 1000 {
        x := A_Index * 2
    }
    Sleep(5)

    elapsed := ProfileEnd(timer)

    MsgBox(
        "Code block executed in:`n"
        "Standard: " elapsed.ElapsedMs " ms`n"
        "High-res: " elapsed.ElapsedMsHighRes " ms"
    )
}

; ============================================================
; Example 5: Compare multiple functions
; ============================================================

MethodA(n) {
    ; Using concatenation
    str := ""
    Loop n
        str .= "x"
    return str
}

MethodB(n) {
    ; Using array join
    arr := []
    Loop n
        arr.Push("x")
    return arr
}

Example5() {
    MsgBox("Example 5: Compare different approaches")

    results := Profiler.Compare([
        {Name: "String Concatenation", Func: MethodA, Args: [100]},
        {Name: "Array Push", Func: MethodB, Args: [100]}
    ], 50)

    MsgBox(Profiler.FormatComparison(results))
}

; ============================================================
; Example 6: Profile fullscreen detection functions
; ============================================================

; #Include "%A_ScriptDir%\module\google-chrome.ahk"

; Example6() {
;     MsgBox("Example 6: Profile fullscreen detection methods")

;     ; Make sure Chrome is running for accurate test
;     if !WinExist("ahk_exe chrome.exe") {
;         MsgBox("Please start Chrome first!")
;         return
;     }

;     results := Profiler.Compare([
;         {Name: "IsChromeFullscreen1 (Style only)", Func: IsChromeFullscreen1},
;         {Name: "IsChromeFullscreen (Hybrid)", Func: IsChromeFullscreen}
;     ], 200)

;     MsgBox(Profiler.FormatComparison(results))
; }

; ============================================================
; Example 7: Profile with detailed timing analysis
; ============================================================

SlowFunction() {
    Sleep(Random(5, 15))  ; Simulate variable execution time
}

Example7() {
    MsgBox("Example 7: Detailed timing analysis")

    stats := ProfileStats(SlowFunction, [], 50)

    output := Profiler.FormatStats(stats)
    output .= "`n`nVariance: " Format("{:.3f}", stats.MaxMs - stats.MinMs) . " ms"
    output .= "`nStandard deviation: " Format("{:.3f}", CalculateStdDev(stats.Times)) . " ms"

    MsgBox(output)
}

CalculateStdDev(arr) {
    ; Calculate mean
    sum := 0
    for val in arr
        sum += val
    mean := sum / arr.Length

    ; Calculate variance
    variance := 0
    for val in arr
        variance += (val - mean) ** 2
    variance /= arr.Length

    ; Standard deviation
    return Sqrt(variance)
}

; ============================================================
; Run examples with hotkeys
; ============================================================

^!1:: Example1()  ; Ctrl+Alt+1
^!2:: Example2()  ; Ctrl+Alt+2
^!3:: Example3()  ; Ctrl+Alt+3
^!4:: Example4()  ; Ctrl+Alt+4
^!5:: Example5()  ; Ctrl+Alt+5
; ^!6:: Example6()  ; Ctrl+Alt+6
^!7:: Example7()  ; Ctrl+Alt+7

MsgBox(
    "Profiler Examples Ready!`n`n"
    "Press:`n"
    "Ctrl+Alt+1 - Profile single function`n"
    "Ctrl+Alt+2 - Profile with statistics`n"
    "Ctrl+Alt+3 - Profile inline code`n"
    "Ctrl+Alt+4 - Manual profiling`n"
    "Ctrl+Alt+5 - Compare methods`n"
    "Ctrl+Alt+6 - Profile Chrome fullscreen detection`n"
    "Ctrl+Alt+7 - Detailed timing analysis"
)
