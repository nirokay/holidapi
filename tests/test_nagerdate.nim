import std/[unittest, strutils]
import holidapi/api/nagerdate

var holidays: seq[Holiday]

test "Fetching holidays":
    holidays = UnitedStates.getHolidays(2024)
    check holidays.len() != 0

test "Reading values":
    for holiday in holidays:
        check holiday.name != ""
