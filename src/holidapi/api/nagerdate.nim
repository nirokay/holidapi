## Countries via nager.date
## ======================================

runnableExamples -d:off:
    import std/[strformat]
    import holidapi/api/nagerdate

    let
        holidays: seq[Holiday] = SouthKorea.getHolidays(2024, bothNames)
        # `bothNames` will get the english and local name of the holiday
        # example:
        #
        # - South Korea: New Year's Day (새해)
        # - France:      New Year's Day (Jour de l'an)
        # - Russia:      New Year's Day (Новый год)

    for holiday in holidays:
        echo &"{holiday.name} is on the " & holiday.dateTime.format("yyyy-MM-dd") &
            &" and goes on for " & $holiday.duration.inDays() & " day(s)!"

import ../shared, ../apis/nagerdate
export shared, nagerdate
