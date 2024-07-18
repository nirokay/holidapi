import std/[times]
import ../types, ../rawtypes, ../client, ../types

type
    OpenHolidaysApiLanguage* = enum
        Belarusian = "BE" ## беларускі
        Bulgarian = "BG" ## Български
        Catalan = "CA" ## Català
        Czech = "CS" ## Česky
        German = "DE" ## Deutsch
        English = "EN" ## English
        Spanish = "ES" ## España
        Estonian = "ET" ## Eesti
        Basque = "EU" ## Euskara
        French = "FR" ## Français
        Irish = "GA" ## Gaeilge
        Galician = "GL" ## Galego
        Croatian  = "HR" ## Hrvatska
        Hungarian = "HU" ## Magyarország
        Italian = "IT" ## Italiano
        Luxembourgish = "LB" ## Lëtzebuergesch
        Lithuanian = "LT" ## Lietuvių
        Latvian = "LV" ## Latviešu
        Maltese = "MT" ## Malti
        Dutch = "NL" ## Nederlands
        Polish = "PL" ## Polska
        Portuguese = "PT" ## Português
        Romansh = "RM" ## Rumantsch
        Romanian = "RO" ## Limba română
        Russian = "RU" ## Русский
        Slovak = "SK" ## Slovenský
        Slovenian = "SL" ## Slovenski
        Albanian = "SQ" ## Shqip

    OpenHolidaysApiCountry* = enum
        Andorra = "AD"
        Albania = "AL"
        Austria = "AT"
        Belgium = "BE"
        Bulgaria = "BG"
        Belarus = "BY"
        Switzerland = "CH"
        Czechia = "CZ"
        Germany = "DE"
        Estonia = "EE"
        Spain = "ES"
        France = "FR"
        Croatia = "HR"
        Hungary = "HU"
        Ireland = "IE"
        Italy = "IT"
        Lichtenstein = "LI"
        Lithuania = "LT"
        Luxembourg = "LU"
        Latvia = "LV"
        Monaco = "MC"
        Moldova = "MD"
        Malta = "MT"
        Netherlands = "NL"
        Poland = "PL"
        Portugal = "PT"
        Romania = "RO"
        Slovenia = "SI"
        SanMarino = "SM"
        VaticanCity = "VA"


proc constructUrl(country: string|OpenHolidaysApiCountry, year: int|DateTime): string =
    let y: int = year.getYear()
    result = @[
        "https://openholidaysapi.org/PublicHolidays?countryIsoCode=", $country,
        "&validFrom=" & $y & "-01-01",
        "&validTo=" & $y & "-12-31",
    ].join("")

proc getHolidays*(country: string|OpenHolidaysApiCountry, year: int|DateTime, language: string|OpenHolidaysApiCountry = English): seq[Holiday] =
    ## Get holidays for country in preferred langauge (english as fallback) for a year
    let
        url: string = constructUrl(year, $country)
        response = url.requestParsedData(seq[OpenHolidaysRawHoliday])

    for holiday in response:
        result.add holiday.toHoliday($language)
