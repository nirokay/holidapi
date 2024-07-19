import std/[unittest, json, strutils]
import holidapi/country/europe

const year: int = 2024
var holidays: seq[Holiday]

test "Fetching holidays":
    holidays = Germany.getHolidays(year)
    check holidays.len() != 0

test "Reading values":
    for holiday in holidays:
        check holiday.name != ""
        if holiday.nationwide.get():
            check holiday.regions.len() == 0
        else:
            check holiday.regions.len() != 0

