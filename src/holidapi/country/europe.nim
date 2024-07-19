## European countries via OpenHolidaysAPI
## ======================================

runnableExamples -d:off:
    import std/[strformat]
    import holidapi/country/europe

    let
        holidaysInEnglish: seq[Holiday] = Netherlands.getHolidays(2024)
        holidaysInDutch {.used.}: seq[Holiday] = Netherlands.getHolidays(2024, Dutch)

    for holiday in holidaysInEnglish:
        echo &"{holiday.name} is on the " & holiday.dateTime.format("yyyy-MM-dd") &
            &" and goes on for " & $holiday.duration.inDays() & " day(s)!"

import ../shared, ../apis/openholidaysapi
export shared, openholidaysapi
