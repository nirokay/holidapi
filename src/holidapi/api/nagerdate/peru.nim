import ../../shared, ../../apis/nagerdate
export shared
export nagerdate except getHolidays, NagerDateApiCountry

const country: NagerDateApiCountry = Peru

proc getHolidays*(year: int|DateTime, nameLanguage: NagerDateNameLanguage = englishName): seq[Holiday] =
    ## Override for country `Peru`
    ##
    ## Get holidays for country in preferred langauge (english as fallback) for a year
    result = country.getHolidays(year, nameLanguage)
