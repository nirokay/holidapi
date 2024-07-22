## OpenHolidaysApi
## ===============
##
## [Website](https://www.openholidaysapi.org/)

import std/[times, strutils]
import ../types, ../rawtypes, ../client

type
    OpenHolidaysApiLanguage* = enum ## https://www.openholidaysapi.org/en/#languages
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

    OpenHolidaysApiCountry* = enum ## https://www.openholidaysapi.org/en/#countries
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


proc constructUrl(country: string, dateFrom, dateTill: DateTime): string =
    ## Constructs the URL for OpenHolidaysApi
    result = @[
        apiUrl.openholidaysapi,
        "countryIsoCode=", $country,
        "&validFrom=" & dateFrom.format(dateFormat),
        "&validTo=" & dateTill.format(dateFormat)
    ].join("")

proc constructUrl(country: string, year: int): string =
    ## Constructs the URL for OpenHolidaysApi
    result = constructUrl(country,
        dateFrom = dateTime(year, mJan, 1),
        dateTill = dateTime(year, mDec, 31)
    )

proc fetch(url: string, language: string|OpenHolidaysApiLanguage): seq[Holiday] =
    ## Fetches a sequence of `Holiday`s from the API
    ##
    ## Raises `HolidAPIError`, if network or JSON parsing encountered errors
    let response = url.requestParsedData(seq[OpenHolidaysRawHoliday])

    for holiday in response:
        result.add holiday.toHoliday($language)

proc getHolidays*(country: string|OpenHolidaysApiCountry, year: int, language: string|OpenHolidaysApiLanguage = English): seq[Holiday] =
    ## Get holidays for country in preferred langauge (english as fallback) for a year
    ##
    ## Raises `HolidAPIError`, if network or JSON parsing encountered errors
    let url: string = constructUrl($country, year)
    result = fetch(url, language)

proc getHolidays*(country: string|OpenHolidaysApiCountry, dateFrom, dateTill: DateTime, language: string|OpenHolidaysApiLanguage = English): seq[Holiday] =
    ## Get holidays for country in preferred langauge (english as fallback) for custom range
    ##
    ## Raises `HolidAPIError`, if network or JSON parsing encountered errors
    let url: string = constructUrl($country, dateFrom, dateTill)
    result = fetch(url, language)
