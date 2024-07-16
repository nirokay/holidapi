type
    HolidAPIError* = object of CatchableError

proc warning*(msg: string) =
    when not defined js:
        stderr.writeLine "[HolidAPI]: " & msg
