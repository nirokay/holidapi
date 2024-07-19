import ../../shared, ../../apis/openholidaysapi
export shared
export openholidaysapi except getHolidays, OpenHolidaysApiCountry

const country: OpenHolidaysApiCountry = Netherlands

proc getHolidays*(year: int|DateTime, language: string|OpenHolidaysApiLanguage = English): seq[Holiday] =
    ## Override for country `Netherlands`
    ##
    ## Get holidays for country in preferred langauge (english as fallback) for a year
    result = country.getHolidays(year, language)
