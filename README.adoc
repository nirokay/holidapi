= HolidAPI

== About

_HolidAPI_ (pronounced: _"Holiday-P-I"_, haha get it?), is a wrapper for multiple APIs serving information about holidays.

== Installation

`nimble install holidapi`

== Currently supported countries

See `./COUNTRIES.adoc` for a list of supported countries.

You do not see your country in this list? Help us by expanding the API wrappers! :D

== Examples

```nim
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

```
```nim
# European holiday API
import std/[strformat]
import holidapi/api/openholidaysapi

let
    holidaysInEnglish: seq[Holiday] = Netherlands.getHolidays(2024)
    holidaysInDutch {.used.}: seq[Holiday] = Netherlands.getHolidays(2024, Dutch)

for holiday in holidaysInEnglish:
    echo &"{holiday.name} is on the " & holiday.dateTime.format("yyyy-MM-dd") &
        &" and goes on for " & $holiday.duration.inDays() & " day(s)!"
```
```nim
# Alternative German API
import std/[strformat]
import holidapi/api/feiertageapi

let response: OrderedTable[GermanState, seq[Holiday]] = getAllHolidays(2024)

for state, holidays in response:
    echo &"Holidays for state {state}:"
    for i, holiday in holidays:
        echo &"{i}: {holiday.name}"
```

See `./src/holidapi/types.nim` for documentation on the `Holiday` type.

== Contributions

Contributions are always welcome, especially expanding the list of supported countries/regions!

== Licence

This project is distributed under the `GPL-3.0` licence.
