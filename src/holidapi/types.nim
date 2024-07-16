import std/[options, times, strutils]

const
    dateFormat*: string = "yyyy-MM-dd"
    apiUrl* = (
        germany: "https://feiertage-api.de/api/?"
    )
    fullDayDuration*: Duration = initDuration(
        hours = 24
    )

type
    Holiday* = object ## Standardized Holiday object
        name*: string ## The name of the holiday
        date*: string ## Raw API response date
        dateTime*: DateTime ## Parsed datetime from `date`
        duration*: Duration ## Holiday duration
        information*: Option[string] ## Additional information, if provided by the API


proc `$`*(holiday: Holiday): string =
    ## Converts `Holiday` to a string
    var elements: seq[string] = @[
        "\"" & holiday.name & "\"",
        "on " & holiday.dateTime.format(dateFormat),
        "for " & $holiday.duration.inHours() & "h"
    ]
    result = elements.join(" ")
