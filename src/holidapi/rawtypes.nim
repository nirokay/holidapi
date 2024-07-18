## Raw Types
## =========
##
## This module contains shared API raw json response types for shared APIs.

type
    OpenHolidayRawName* = tuple[language, text: string]
    OpenHolidaysRawHoliday* = object
        endDate*: string ## Holiday ending date
        id*: string ## Holiday ID
        name*: seq[OpenHolidayRawName] ## Holiday name(s)
        nationwide*: bool ## Regional/National holiday
        startDate*: string ## Holiday starting date
        `type`*: string ## Public holiday or not

    OpenHolidaysRawResponse* = seq[OpenHolidaysRawHoliday]
