## Feiertage-API
## =============
##
## [Website](https://www.feiertage-api.de/)

import std/[strutils]
import ../shared
export shared

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
    GermanApiFullResponse* = OrderedTable[string, OrderedTable[string, GermanApiHoliday]] ## Raw full API response

proc getState*(short: string): Option[GermanState] =
    ## Gets the enum from its value.
    for state in GermanState:
        if $state == short: return some state

proc constructUrl*(year: int, onlyDates: bool, onlyState: string = ""): string =
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