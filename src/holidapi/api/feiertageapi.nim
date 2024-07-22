import std/[tables, times, options]
import ../shared, ../client, ../apis/feiertageapi
export shared
export GermanState

proc getAllHolidays*(year: int|DateTime): OrderedTable[GermanState, seq[Holiday]] {.raises: [HolidAPIError, TimeParseError, Exception].} =
    ## Gets all German holidays in a Table `GermanState -> seq[Holiday]`
    ##
    ## Raises `HolidAPIError` in case the state shorthand cannot be parsed to a
    ## state in the `GermanState` enum.
    let
        y: int = getYear(year)
        response: GermanApiFullResponse = requestParsedData(constructUrl(y, false, ""), GermanApiFullResponse)

    for state, list in response:
        var holidays: seq[Holiday]
        for name, data in list:
            let parsedDate: DateTime = parse(data.datum, dateFormat)
            holidays.add Holiday(
                name: name,
                date: data.datum,
                dateTime: parsedDate,
                duration: fullDayDuration,
                information: data.hinweis
            )
        let s: Option[GermanState] = getState(state)
        if unlikely s.isNone():
            raise HolidAPIError.newException("Failed to parse '" & $state & "' to a " & $GermanState & "!")
        result[get s] = holidays

proc getStateHolidays*(year: int|DateTime, state: GermanState): seq[Holiday] =
    ## Gets only German holidays for a given state in a sequence.
    ##
    ## Raises `HolidAPIError` in case the state was not in the API response
    ## (this should never happen under normal circumstances).
    let allHolidays: OrderedTable[GermanState, seq[Holiday]] = getAllHolidays(year)
    if unlikely(not allHolidays.hasKey(state)):
        raise HolidAPIError.newException("Could not get '" & $state & "' from API response, returning empty sequence.")
    result = allHolidays[state]
