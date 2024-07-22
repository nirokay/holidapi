import std/[unittest, json, strutils, times, sequtils]
import holidapi/api/openholidaysapi

const year: int = 2024
var
    holidaysYear: seq[Holiday]
    holidaysMultipleYears: seq[Holiday]

test "Fetching holidays - year":
    holidaysYear = Germany.getHolidays(year)
    check holidaysYear.len() != 0

test "Reading values":
    for holiday in holidaysYear:
        check holiday.name != ""
        if holiday.nationwide.get():
            check holiday.regions.len() == 0
        else:
            check holiday.regions.len() != 0

test "Fetching holidays - custom range":
    holidaysMultipleYears = Germany.getHolidays(
        dateFrom = dateTime(year - 1, mJan, 1),
        dateTill = dateTime(year + 1, mDec, 31)
    )

    check holidaysMultipleYears.len() > holidaysYear.len()

test "Reading values - custom range":
    var names: seq[string]
    for holiday in holidaysMultipleYears:
        names.add holiday.name

    check names.deduplicate().len() < names.len() and names.deduplicate().len() != 0
