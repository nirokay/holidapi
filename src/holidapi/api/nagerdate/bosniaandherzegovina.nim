import ../../shared, ../../apis/nagerdate
export shared
export nagerdate except getHolidays, NagerDateApiCountry

const country: NagerDateApiCountry = BosniaAndHerzegovina

proc getHolidays*(year: int|DateTime, nameLanguage: NagerDateNameLanguage = englishName): seq[Holiday] =
    ## Override for country `BosniaAndHerzegovina`
    ##
    ## Get holidays for country in for a year
    result = country.getHolidays(year, nameLanguage)
