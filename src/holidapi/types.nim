import std/[options, times, strutils]
import rawtypes, errors

const
    dateFormat*: string = "yyyy-MM-dd"
    apiUrl* = (
        germany: "https://feiertage-api.de/api/?"
    )
    fullDayDuration*: Duration = initDuration(
        hours = 24
    )


proc getYear*(year: int): int = year ## Gets the year as `int`
proc getYear*(year: DateTime): int = year.year ## Gets the year as `int`


type
    Holiday* = object ## Standardized Holiday object
        name*: string ## The name of the holiday
        date*: string ## Raw API response date
        dateTime*: DateTime ## Parsed datetime from `date`
        duration*: Duration ## Holiday duration
        information*: Option[string] ## Additional information, if provided by the API
        nationwide*: Option[bool] ## is `None` when information could not be gotten
        regions*: seq[string] ## Check `Holiday.nationwide` first, if `false` this will be populated, if information is provided

proc `$$`*(holiday: Holiday): string =
    ## Debug `$` stringification, like for all other objects
    result = $holiday

proc `$`*(holiday: Holiday): string =
    ## Converts `Holiday` to a string
    var elements: seq[string] = @[
        "\"" & holiday.name & "\"",
        "on " & holiday.dateTime.format(dateFormat),
        "for " & $holiday.duration.inHours() & "h"
    ]
    result = elements.join(" ")

proc getNameInPreferredLanguage(name: seq[OpenHolidayRawName], language: string): string =
    ## Tries to get the name of a holiday in a language, falls back to english, if
    ## this fails. If this fails as well, it returns the first language in the sequence.
    if unlikely name.len() == 0:
        warning("Language block was empty, returning empty string...")
        return ""
    var english: Option[string]
    for element in name:
        let elementLanguage: string = element.language.toLower()
        # Preferred language:
        if elementLanguage == language.toLower():
            return element.text
        # Fallback to english:
        if elementLanguage == "en":
            english = some element.text

    # Return english, if found:
    if likely english.isSome():
        warning("Did not find preferred lanuage '" & language & "', returning English.")
        return get english

    # Return first element, if preferred language and english not there:
    warning("Did not find preferred language '" & language & "', did not find English, returning first language given.")
    result = name[0].text

proc toHoliday*(holiday: OpenHolidaysRawHoliday, preferredLanguage = "EN"): Holiday =
    let name: string = holiday.name.getNameInPreferredLanguage(preferredLanguage)
    result = Holiday(
        name: name,
        date: (
            if holiday.startDate == holiday.endDate: holiday.startDate
            else: holiday.startDate & " - " & holiday.endDate
        )
    )

    let
        startDate: DateTime = parse(holiday.startDate, dateFormat)
        endDate: DateTime = parse(holiday.startDate, dateFormat) + days(1)
    result.dateTime = startDate
    result.duration = endDate - startDate

    result.nationwide = some holiday.nationwide
    if holiday.subdivisions.isSome():
        for region in holiday.subdivisions.get():
            if region.shortName != "": result.regions.add region.shortName
            else: result.regions.add region.code

    if name == "":
        warning(@[
            "Failed to parse name of holiday, field `name` remains empty.",
            "Raw `OpenHolidaysRawHoliday` object: " & $holiday,
            "Parsed `Holiday` object: " & $result
        ])
