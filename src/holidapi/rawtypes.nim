## Raw Types
## =========
##
## This module contains shared API raw json response types for shared APIs.

import std/[options]

type
    OpenHolidayRawName* = tuple[language, text: string]
    OpenHolidayRawSubdivision* = tuple[code, shortName: string]
    OpenHolidaysRawHoliday* = object
        endDate*: string ## Holiday ending date
        id*: string ## Holiday ID
        name*: seq[OpenHolidayRawName] ## Holiday name(s)
        nationwide*: bool ## Regional/National holiday
        startDate*: string ## Holiday starting date
        subdivisions*: Option[seq[OpenHolidayRawSubdivision]]
        `type`*: string ## Public holiday or not

    OpenHolidaysRawResponse* = seq[OpenHolidaysRawHoliday]
