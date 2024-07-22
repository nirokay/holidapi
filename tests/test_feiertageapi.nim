import std/[unittest, json, tables, strutils]
import holidapi/api/feiertageapi

const
    year: int = 2024
    state: GermanState = Bavaria


test "Full API response":
    let response: OrderedTable[GermanState, seq[Holiday]] = getAllHolidays(year)
    check response[state].len() > 5

test "Only state " & $state:
    let response: seq[Holiday] = getStateHolidays(year, state)
    check response.len() > 5

test "Only 'state' " & $National:
    let response: seq[Holiday] = getStateHolidays(year, National)
    check response.len() > 5
