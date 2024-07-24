## nager.date
## ==========
##
## [Website](https://date.nager.at/)

import std/[strutils]
import ../shared, ../rawtypes, ../client
export shared

type
    NagerDateApiCountry* = enum ## https://date.nager.at/Country
        Andorra = "AD"
        Albania = "AL"
        Armenia = "AM"
        Argentina = "AR"
        Austria = "AT"
        Australia = "AU"
        AlandIslands = "AX" ## Åland Islands
        BosniaAndHerzegovina = "BA"
        Barbados = "BB"
        Belgium = "BE"
        Bulgaria = "BG"
        Benin = "BJ"
        Bolivia = "BO"
        Brazil = "BR"
        Bahamas = "BS"
        Botswana = "BW"
        Belarus = "BY"
        Belize = "BZ"
        Canada = "CA"
        Switzerland = "CH"
        Chile = "CL"
        China = "CN"
        Colombia = "CO"
        CostaRica = "CR"
        Cuba = "CU"
        Cyprus = "CY"
        Czechia = "CZ"
        Germany = "DE"
        Denmark = "DK"
        DominicanRepublic = "DO"
        Ecuador = "EC"
        Estonia = "EE"
        Egypt = "EG"
        Spain = "ES"
        Finland = "FI"
        FaroeIslands = "FO"
        France = "FR"
        Gabon = "GA"
        UnitedKingdom = "GB"
        Grenada = "GD"
        Georgia = "GE"
        Guernsey = "GG"
        Gibraltar = "GI"
        Greenland = "GL"
        Gambia = "GM"
        Greece = "GR"
        Guatemala = "GT"
        Guyana = "GY"
        HongKong = "HK"
        Honduras = "HN"
        Croatia = "HR"
        Haiti = "HT"
        Hungary = "HU"
        Indonesia = "ID"
        Ireland = "IE"
        IsleOfMan = "IM"
        Iceland = "IS"
        Italy = "IT"
        Jersey = "JE"
        Jamaica = "JM"
        Japan = "JP"
        SouthKorea = "KR"
        Kazakhstan = "KZ"
        Liechtenstein = "LI"
        Lesotho = "LS"
        Lithuania = "LT"
        Luxembourg = "LU"
        Latvia = "LV"
        Morocco = "MA"
        Monaco = "MC"
        Moldova = "MD"
        Montenegro = "ME"
        Madagascar = "MG"
        NorthMacedonia = "MK"
        Mongolia = "MN"
        Montserrat = "MS"
        Malta = "MT"
        Mexico = "MX"
        Mozambique = "MZ"
        Namibia = "NA"
        Niger = "NE"
        Nigeria = "NG"
        Nicaragua = "NI"
        Netherlands = "NL"
        Norway = "NO"
        NewZealand = "NZ"
        Panama = "PA"
        Peru = "PE"
        PapuaNewGuinea = "PG"
        Poland = "PL"
        PuertoRico = "PR"
        Portugal = "PT"
        Paraguay = "PY"
        Romania = "RO"
        Serbia = "RS"
        Russia = "RU"
        Sweden = "SE"
        Singapore = "SG"
        Slovenia = "SI"
        SvalbardAndJanMayen = "SJ"
        Slovakia = "SK"
        SanMarino = "SM"
        Suriname = "SR"
        ElSalvador = "SV"
        Tunisia = "TN"
        Turkey = "TR"
        Ukraine = "UA"
        UnitedStates = "US"
        Uruguay = "UY"
        VaticanCity = "VA"
        Venezuela = "VE"
        Vietnam = "VN"
        SouthAfrica = "ZA"
        Zimbabwe = "ZW"

proc constructUrl(country: string|NagerDateApiCountry, year: int): string =
    ## Constructs the URL for nager.date
    result = @[
        apiUrl.nagerdate,
        $year,
        $country
    ].join("/")

proc getHolidays*(country: string|NagerDateApiCountry, year: int, names: NagerDateNameLanguage = englishName): seq[Holiday] =
    ## Get holidays for country for a year
    ##
    ## Raises `HolidAPIError`, if network or JSON parsing encountered errors
    let
        url: string = constructUrl(country, year)
        response = url.requestParsedData(seq[NagerDateRawHoliday])

    for holiday in response:
        result.add holiday.toHoliday(names)
