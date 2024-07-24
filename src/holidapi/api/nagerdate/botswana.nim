import ../../shared, ../../apis/nagerdate
export shared
export nagerdate except getHolidays, NagerDateApiCountry

const country: NagerDateApiCountry = Botswana

proc getHolidays*(year: int|DateTime, nameLanguage: NagerDateNameLanguage = englishName): seq[Holiday] =
    ## Override for country `Botswana`
    ##
    ## Get holidays for country in for a year
    result = country.getHolidays(year, nameLanguage)
