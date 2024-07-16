import std/[tables, times, options, strutils]
import ../types, ../client, ../errors

export tables

const timeFormat: string = "yyyy-MM-dd"
proc time(date: string): DateTime =
    ## Gets the `DateTime` from the API timestamp
    result = parse(date, timeFormat)

type
    GermanState* = enum ## German states (Bundesländer)
        National = "NATIONAL"

        BadenWürtemberg = "BW"
        Bavaria = "BY"
        Berlin = "BE"
        Brandenburg = "BB"

        Bremen = "HB"
        Hamburg = "HH"
        Hesse = "HE"
        MeklenburgVorpommern = "MV"

        LowerSaxony = "NI"
        NorthRhineWestphalia = "NW"
        RhinelandPalatinate = "RP"
        Saarland = "SL"

        Saxony = "SN"
        SaxonyAnhalt = "ST"
        SchleswigHolstein = "SH",
        Thuringia = "TH"

    GermanApiHoliday = object ## Raw API response for a holiday
        datum*: string
        hinweis*: Option[string]
    GermanApiFullResponse = OrderedTable[string, OrderedTable[string, GermanApiHoliday]] ## Raw full API response

    GermanFullResponse* = OrderedTable[GermanState, seq[Holiday]] ## Contains the full, parsed response from the API
    GermanOnlyDatesResponse* = seq[Holiday] ## type alias for `seq[Holiday]`

proc constructUrl(year: int, onlyDates: bool, onlyState: string = ""): string =
    ## Constructs the url, im very lazy lol
    result = apiUrl.germany
    var params: seq[string] = @[
        "jahr=" & $year
    ]

    if $onlyState != "":
        params.add "nur_land=" & $onlyState
    if onlyDates:
        params.add "nur_daten=1"

    result &= params.join("&")

proc getYear(year: int): int = year ## Gets the year as `int`
proc getYear(year: DateTime): int = year.year ## Gets the year as `int`

proc getState(short: string): Option[GermanState] =
    ## Gets the enum from its value.
    for state in GermanState:
        if $state == short: return some state

proc getAllHolidays*(year: int|DateTime): GermanFullResponse {.raises: [HolidAPIError, TimeParseError, Exception].} =
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
            let parsedDate: DateTime = time(data.datum)
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

proc getStateHolidays*(year: int|DateTime, state: GermanState): GermanOnlyDatesResponse =
    ## Gets only German holidays for a given state in a sequence.
    let allHolidays: GermanFullResponse = getAllHolidays(year)
    if allHolidays.hasKey(state):
        result = allHolidays[state]
    else:
        result = @[]
