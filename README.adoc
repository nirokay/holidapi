= HolidAPI

== About

_HolidAPI_ (pronounced: _"Holiday-P-I"_, haha get it?), is a wrapper for multiple APIs serving information about holidays.

== Currently supported countries

* Germany via https://www.feiertage-api.de/[feiertage-api.de]

== Examples

```nim
import std/[strformat]
import holidapi/country/germany

const
    year: int = 2024

let response: OrderedTable[GermanState, seq[Holiday]] = getAllHolidays(year)

for state, holidays in response:
    echo &"Holidays for state {state}:"
    for i, holiday in holidays:
        echo &"{i}: {holiday.name}"
```
