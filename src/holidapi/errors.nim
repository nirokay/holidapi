type
    HolidAPIError* = object of CatchableError

proc warning*(msg: string) =
    ## Displays a single-lined warning message to `stderr`
    when not defined js:
        stderr.writeLine "[HolidAPI]: " & msg

proc warning*(msgs: seq[string]) =
    ## Displays a multi-lined warning message to `stderr`
    let
        sep: string = "---------------"
        lines: seq[string] = ("- BEGIN " & sep) & msgs & ("- END " & sep)

    for line in lines:
        warning(line)
