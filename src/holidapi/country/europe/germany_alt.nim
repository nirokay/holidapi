import std/[tables, times, options, strutils]
import ../../shared, ../../client
export shared

const timeFormat: string = "yyyy-MM-dd"
proc time(date: string): DateTime =
    ## Gets the `DateTime` from the API timestamp
    result = parse(date, timeFormat)

type
    GermanState* = enum ## German states (Bundesländer)
        National = "NATIONAL" ## National/Bundesweit

        BadenWürtemberg = "BW" ## Baden-Würtemberg
        Bavaria = "BY" ## Bayern
        Berlin = "BE" ## Berlin
        Brandenburg = "BB" ## Brandenburg

        Bremen = "HB" ## Bremen
        Hamburg = "HH" ## Hamburg
        Hesse = "HE" ## Hessen
        MeklenburgVorpommern = "MV" ## Meklemburg-Vorpommern

        LowerSaxony = "NI" ## Niedersachsen
        NorthRhineWestphalia = "NW" ## Nordrhein-Westphalen
        RhinelandPalatinate = "RP" ## Rheinland-Pfalz
        Saarland = "SL" ## Saarland

        Saxony = "SN" ## Sachsen
        SaxonyAnhalt = "ST" ## Sachsen-Anhalt
        SchleswigHolstein = "SH", ## Schleswig-Holstein
        Thuringia = "TH" ## Thüringen

    GermanApiHoliday = object ## Raw API response for a holiday
        datum*: string
        hinweis*: Option[string]
    GermanApiFullResponse = OrderedTable[string, OrderedTable[string, GermanApiHoliday]] ## Raw full API response

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

proc getState(short: string): Option[GermanState] =
    ## Gets the enum from its value.
    for state in GermanState:
        if $state == short: return some state

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

proc getStateHolidays*(year: int|DateTime, state: GermanState): seq[Holiday] =
    ## Gets only German holidays for a given state in a sequence.
    ##
    ## Raises `HolidAPIError` in case the state was not in the API response
    ## (this should never happen under normal circumstances).
    let allHolidays: OrderedTable[GermanState, seq[Holiday]] = getAllHolidays(year)
    if unlikely(not allHolidays.hasKey(state)):
        raise HolidAPIError.newException("Could not get '" & $state & "' from API response, returning empty sequence.")
    result = allHolidays[state]
