/**
 * Function Profiler - Measure execution time of functions
 * 
 * Usage Examples:
 * 
 * 1. Profile a single execution:
 *    result := Profile(MyFunction, [arg1, arg2])
 *    MsgBox("Executed in " result.ElapsedMs " ms")
 * 
 * 2. Profile with multiple iterations:
 *    stats := ProfileStats(MyFunction, [arg1, arg2], 100)
 *    MsgBox("Average: " stats.AvgMs " ms, Min: " stats.MinMs " ms, Max: " stats.MaxMs " ms")
 * 
 * 3. Profile inline with lambda:
 *    result := Profile(() => Send("Hello"))
 * 
 * 4. Profile a code block:
 *    timer := ProfileStart()
 *    ; ... your code here ...
 *    elapsed := ProfileEnd(timer)
 */

class Profiler {
    /**
     * Profile a single function execution
     * @param func Function or lambda to profile
     * @param args Array of arguments to pass to the function (optional)
     * @returns Object with {Result, ElapsedMs, ElapsedTicks}
     */
    static Profile(func, args := []) {
        startTick := A_TickCount
        startQPC := this.QueryPerformanceCounter()
        
        result := func.Call(args*)
        
        endQPC := this.QueryPerformanceCounter()
        endTick := A_TickCount
        
        return {
            Result: result,
            ElapsedMs: endTick - startTick,
            ElapsedTicks: endQPC - startQPC,
            ElapsedMsHighRes: this.TicksToMs(endQPC - startQPC)
        }
    }
    
    /**
     * Profile a function with multiple iterations and get statistics
     * @param func Function to profile
     * @param args Array of arguments (optional)
     * @param iterations Number of times to run (default: 100)
     * @returns Object with statistics {AvgMs, MinMs, MaxMs, MedianMs, TotalMs, Iterations}
     */
    static ProfileStats(func, args := [], iterations := 100) {
        times := []
        totalMs := 0
        minMs := 999999999
        maxMs := 0
        
        Loop iterations {
            startTick := A_TickCount
            startQPC := this.QueryPerformanceCounter()
            
            func.Call(args*)
            
            endQPC := this.QueryPerformanceCounter()
            elapsed := this.TicksToMs(endQPC - startQPC)
            
            times.Push(elapsed)
            totalMs += elapsed
            minMs := Min(minMs, elapsed)
            maxMs := Max(maxMs, elapsed)
        }
        
        ; Calculate median
        times := this.Sort(times)
        medianMs := (iterations mod 2 = 1) 
            ? times[iterations // 2 + 1] 
            : (times[iterations // 2] + times[iterations // 2 + 1]) / 2
        
        return {
            AvgMs: totalMs / iterations,
            MinMs: minMs,
            MaxMs: maxMs,
            MedianMs: medianMs,
            TotalMs: totalMs,
            Iterations: iterations,
            Times: times
        }
    }
    
    /**
     * Start a manual profiling session
     * @returns Timer object with start times
     */
    static Start() {
        return {
            StartTick: A_TickCount,
            StartQPC: this.QueryPerformanceCounter()
        }
    }
    
    /**
     * End a manual profiling session
     * @param timer Timer object from ProfileStart()
     * @returns Object with {ElapsedMs, ElapsedMsHighRes}
     */
    static End(timer) {
        endTick := A_TickCount
        endQPC := this.QueryPerformanceCounter()
        
        return {
            ElapsedMs: endTick - timer.StartTick,
            ElapsedMsHighRes: this.TicksToMs(endQPC - timer.StartQPC),
            ElapsedTicks: endQPC - timer.StartQPC
        }
    }
    
    /**
     * Compare execution time of multiple functions
     * @param functions Array of {Name, Func, Args} objects
     * @param iterations Number of iterations per function
     * @returns Array of results with comparison data
     */
    static Compare(functions, iterations := 100) {
        results := []
        fastest := 999999999
        
        ; Profile each function
        for func in functions {
            stats := this.ProfileStats(func.Func, func.HasOwnProp("Args") ? func.Args : [], iterations)
            results.Push({
                Name: func.Name,
                AvgMs: stats.AvgMs,
                MinMs: stats.MinMs,
                MaxMs: stats.MaxMs,
                MedianMs: stats.MedianMs
            })
            fastest := Min(fastest, stats.AvgMs)
        }
        
        ; Add comparison ratios
        for result in results {
            result.SlowerThan := result.AvgMs / fastest
            result.IsFastest := (result.AvgMs = fastest)
        }
        
        return results
    }
    
    /**
     * Format profiling results as a readable string
     * @param stats Stats object from ProfileStats()
     * @returns Formatted string
     */
    static FormatStats(stats) {
        return Format(
            "Iterations: {1}`n"
            "Average: {2:.3f} ms`n"
            "Median: {3:.3f} ms`n"
            "Min: {4:.3f} ms`n"
            "Max: {5:.3f} ms`n"
            "Total: {6:.3f} ms",
            stats.Iterations,
            stats.AvgMs,
            stats.MedianMs,
            stats.MinMs,
            stats.MaxMs,
            stats.TotalMs
        )
    }
    
    /**
     * Format comparison results as a readable string
     * @param results Results from Compare()
     * @returns Formatted string
     */
    static FormatComparison(results) {
        output := "Performance Comparison:`n`n"
        
        for result in results {
            output .= result.Name 
                . (result.IsFastest ? " ⭐ (fastest)" : "")
                . "`n"
                . "  Average: " Format("{:.3f}", result.AvgMs) . " ms"
                . (result.IsFastest ? "" : Format(" ({:.1f}x slower)", result.SlowerThan))
                . "`n"
                . "  Median: " Format("{:.3f}", result.MedianMs) . " ms"
                . "`n`n"
        }
        
        return output
    }
    
    ; Internal helper methods
    
    static QueryPerformanceCounter() {
        DllCall("QueryPerformanceCounter", "Int64*", &counter := 0)
        return counter
    }
    
    static QueryPerformanceFrequency() {
        static freq := 0
        if (freq = 0) {
            DllCall("QueryPerformanceFrequency", "Int64*", &freq)
        }
        return freq
    }
    
    static TicksToMs(ticks) {
        return (ticks * 1000.0) / this.QueryPerformanceFrequency()
    }
    
    static Sort(arr) {
        ; Simple bubble sort for small arrays
        n := arr.Length
        Loop n - 1 {
            i := A_Index
            Loop n - i {
                j := A_Index
                if (arr[j] > arr[j + 1]) {
                    temp := arr[j]
                    arr[j] := arr[j + 1]
                    arr[j + 1] := temp
                }
            }
        }
        return arr
    }
}

; Convenience functions for shorter syntax

/**
 * Profile a single function execution
 * @param func Function to profile
 * @param args Arguments array (optional)
 * @returns Profiling result object
 */
Profile(func, args := []) {
    return Profiler.Profile(func, args)
}

/**
 * Profile with statistics over multiple iterations
 * @param func Function to profile
 * @param args Arguments array (optional)
 * @param iterations Number of iterations (default: 100)
 * @returns Statistics object
 */
ProfileStats(func, args := [], iterations := 100) {
    return Profiler.ProfileStats(func, args, iterations)
}

/**
 * Start a manual profiling timer
 * @returns Timer object
 */
ProfileStart() {
    return Profiler.Start()
}

/**
 * End a manual profiling timer
 * @param timer Timer object from ProfileStart()
 * @returns Elapsed time object
 */
ProfileEnd(timer) {
    return Profiler.End(timer)
}
