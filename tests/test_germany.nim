import std/[unittest, json, tables]
import holidapi/country/germany

const
    year: int = 2024
    state: GermanState = Bavaria
    rawResponseFull: string = """{"BW":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Heilige Drei K\u00f6nige":{"datum":"2024-01-06","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Fronleichnam":{"datum":"2024-05-30","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Reformationstag":{"datum":"2024-10-31","hinweis":"Gem\u00e4\u00df \u00a7 4 Abs. 3 des Feiertagsgesetzes von Baden-W\u00fcrttemberg[10] haben Sch\u00fcler am Gr\u00fcndonnerstag und am Reformationstag schulfrei. In der Regel legt das Kultusministerium die Ferientermine so fest, dass diese beiden Tage in die Osterferien bzw. in die Herbstferien fallen."},"Allerheiligen":{"datum":"2024-11-01","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"BY":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Heilige Drei K\u00f6nige":{"datum":"2024-01-06","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Fronleichnam":{"datum":"2024-05-30","hinweis":""},"Augsburger Friedensfest":{"datum":"2024-08-08","hinweis":"Das Augsburger Friedensfest ist nur im Stadtgebiet Augsburg (nicht jedoch im angrenzenden Umland) gesetzlicher Feiertag (Art. 1 Abs. 2 Bayerisches Feiertagsgesetz[7])."},"Mari\u00e4 Himmelfahrt":{"datum":"2024-08-15","hinweis":"Mari\u00e4 Himmelfahrt ist in Bayern in von den derzeit 1704[8] (Zensus 2011, bis 2013: 1700) Gemeinden mit \u00fcberwiegend katholischer Bev\u00f6lkerung gesetzlicher Feiertag, in den restlichen 352 (Zensus 2011, bis 2013: 356) Gemeinden nicht. Gem\u00e4\u00df Art. 1 Abs. 3 des Bayerischen Feiertagsgesetzes[7] ist es Aufgabe des Bayerischen Landesamtes f\u00fcr Statistik und Datenverarbeitung, festzustellen, in welchen Gemeinden Mari\u00e4 Himmelfahrt gesetzlicher Feiertag ist. Die aktuelle Festlegung beruht auf dem Ergebnis der letzten in der Bundesrepublik Deutschland durchgef\u00fchrten Volksz\u00e4hlung vom 25. Mai 1987. Gem\u00e4\u00df Art 4. Abs. 3 des Bayerischen Feiertagsgesetzes entf\u00e4llt im gesamten Bundesland zu Mari\u00e4 Himmelfahrt an Schulen aller Gattungen der Unterricht. Diese Festlegung gilt ausdr\u00fccklich auch in den Teilen Bayerns, in denen dieser Tag kein gesetzlicher Feiertag ist. Eine \u00dcbersichtskarte aller Gemeinden, in denen Mari\u00e4 Himmelfahrt ein Feiertag ist, kann beim Bayerischen Landesamt f\u00fcr Statistik und Datenverarbeitung heruntergeladen werden (Link siehe unter \"Weitere Weblinks\")."},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Allerheiligen":{"datum":"2024-11-01","hinweis":""},"Bu\u00df- und Bettag":{"datum":"2024-11-20","hinweis":"Gem\u00e4\u00df Art. 4 Nr. 3 des Bayerischen Feiertagsgesetzes[7] entf\u00e4llt im gesamten Bundesland am Bu\u00df- und Bettag an allen Schulen der Unterricht."},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"BE":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Frauentag":{"datum":"2024-03-08","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"BB":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostersonntag":{"datum":"2024-03-31","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstsonntag":{"datum":"2024-05-19","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Reformationstag":{"datum":"2024-10-31","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"HB":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Reformationstag":{"datum":"2024-10-31","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"HH":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Reformationstag":{"datum":"2024-10-31","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"HE":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Fronleichnam":{"datum":"2024-05-30","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"MV":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Frauentag":{"datum":"2024-03-08","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Reformationstag":{"datum":"2024-10-31","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"NI":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Reformationstag":{"datum":"2024-10-31","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"NW":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Fronleichnam":{"datum":"2024-05-30","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Allerheiligen":{"datum":"2024-11-01","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"RP":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Fronleichnam":{"datum":"2024-05-30","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Allerheiligen":{"datum":"2024-11-01","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"SL":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Fronleichnam":{"datum":"2024-05-30","hinweis":""},"Mari\u00e4 Himmelfahrt":{"datum":"2024-08-15","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Allerheiligen":{"datum":"2024-11-01","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"SN":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Fronleichnam":{"datum":"2024-05-30","hinweis":"Fronleichnam ist kein gesetzlicher Feiertag au\u00dfer in folgenden katholisch gepr\u00e4gten Gemeinden des sorbischen Siedlungsgebietes im Landkreis Bautzen:\n\t\t\t\tBautzen (nur in den Ortsteilen Bolbritz und Salzenforst), Crostwitz, G\u00f6da (nur im Ortsteil Prischwitz), Gro\u00dfdubrau (nur im Ortsteil Sdier), Hoyerswerda (nur im Ortsteil D\u00f6rgenhausen), K\u00f6nigswartha (nicht im Ortsteil Wartha), Nebelsch\u00fctz, Neschwitz (nur in den Ortsteilen Neschwitz und Saritsch), Panschwitz-Kuckau, Puschwitz, R\u00e4ckelwitz, Radibor, Ralbitz-Rosenthal und Wittichenau. Entscheidend ist dabei der Arbeitsort, nicht der Wohnort eines Arbeitnehmers.\n\t\t\t\tDie gesetzliche Grundlage f\u00fcr diese durch die Fronleichnamsverordnung festgelegte Regelung ergibt sich aus \u00a7 1 Abs. 1 des S\u00e4chsischen Feiertagsgesetzes.[5]"},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Reformationstag":{"datum":"2024-10-31","hinweis":""},"Bu\u00df- und Bettag":{"datum":"2024-11-20","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"ST":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Heilige Drei K\u00f6nige":{"datum":"2024-01-06","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Reformationstag":{"datum":"2024-10-31","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"SH":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Reformationstag":{"datum":"2024-10-31","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"TH":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Fronleichnam":{"datum":"2024-05-30","hinweis":"Fronleichnam ist kein gesetzlicher Feiertag au\u00dfer im gesamten Landkreis Eichsfeld (79 Gemeinden am 31. Dezember 2013, Auflistung siehe dort) sowie in folgenden Gemeinden des Unstrut-Hainich-Kreises und des Wartburgkreises:\n\t\t\t\tAnrode (nur in den Ortsteilen Bickenriede und Zella), Brunnhartshausen (nur in den Ortsteilen F\u00f6hlritz und Steinberg), Buttlar, D\u00fcnwald (nur in den Ortsteilen Beberstedt und H\u00fcpstedt), Geisa, Rodeberg (nur im Ortsteil Struth), Schleid, S\u00fcdeichsfeld und Zella\/Rh\u00f6n.\n\t\t\t\tDie gesetzliche Grundlage f\u00fcr diese Regelung ergibt sich aus \u00a7 2 Abs. 2 und \u00a7 10 Abs. 1 des Th\u00fcringer Feiertagsgesetzes.[6]"},"Weltkindertag":{"datum":"2024-09-20","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Reformationstag":{"datum":"2024-10-31","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}},"NATIONAL":{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}}}"""
    rawResponseOnlyDates: string = """{"Neujahrstag":"2024-01-01","Heilige Drei K\u00f6nige":"2024-01-06","Frauentag":"2024-03-08","Gr\u00fcndonnerstag":"2024-03-28","Karfreitag":"2024-03-29","Ostersonntag":"2024-03-31","Ostermontag":"2024-04-01","Tag der Arbeit":"2024-05-01","Christi Himmelfahrt":"2024-05-09","Pfingstsonntag":"2024-05-19","Pfingstmontag":"2024-05-20","Fronleichnam":"2024-05-30","Augsburger Friedensfest":"2024-08-08","Mari\u00e4 Himmelfahrt":"2024-08-15","Weltkindertag":"2024-09-20","Tag der Deutschen Einheit":"2024-10-03","Reformationstag":"2024-10-31","Allerheiligen":"2024-11-01","Bu\u00df- und Bettag":"2024-11-20","1. Weihnachtstag":"2024-12-25","2. Weihnachtstag":"2024-12-26"}"""
    rawResponseOnlyState: string = """{"Neujahrstag":{"datum":"2024-01-01","hinweis":""},"Heilige Drei K\u00f6nige":{"datum":"2024-01-06","hinweis":""},"Karfreitag":{"datum":"2024-03-29","hinweis":""},"Ostermontag":{"datum":"2024-04-01","hinweis":""},"Tag der Arbeit":{"datum":"2024-05-01","hinweis":""},"Christi Himmelfahrt":{"datum":"2024-05-09","hinweis":""},"Pfingstmontag":{"datum":"2024-05-20","hinweis":""},"Fronleichnam":{"datum":"2024-05-30","hinweis":""},"Augsburger Friedensfest":{"datum":"2024-08-08","hinweis":"Das Augsburger Friedensfest ist nur im Stadtgebiet Augsburg (nicht jedoch im angrenzenden Umland) gesetzlicher Feiertag (Art. 1 Abs. 2 Bayerisches Feiertagsgesetz[7])."},"Mari\u00e4 Himmelfahrt":{"datum":"2024-08-15","hinweis":"Mari\u00e4 Himmelfahrt ist in Bayern in von den derzeit 1704[8] (Zensus 2011, bis 2013: 1700) Gemeinden mit \u00fcberwiegend katholischer Bev\u00f6lkerung gesetzlicher Feiertag, in den restlichen 352 (Zensus 2011, bis 2013: 356) Gemeinden nicht. Gem\u00e4\u00df Art. 1 Abs. 3 des Bayerischen Feiertagsgesetzes[7] ist es Aufgabe des Bayerischen Landesamtes f\u00fcr Statistik und Datenverarbeitung, festzustellen, in welchen Gemeinden Mari\u00e4 Himmelfahrt gesetzlicher Feiertag ist. Die aktuelle Festlegung beruht auf dem Ergebnis der letzten in der Bundesrepublik Deutschland durchgef\u00fchrten Volksz\u00e4hlung vom 25. Mai 1987. Gem\u00e4\u00df Art 4. Abs. 3 des Bayerischen Feiertagsgesetzes entf\u00e4llt im gesamten Bundesland zu Mari\u00e4 Himmelfahrt an Schulen aller Gattungen der Unterricht. Diese Festlegung gilt ausdr\u00fccklich auch in den Teilen Bayerns, in denen dieser Tag kein gesetzlicher Feiertag ist. Eine \u00dcbersichtskarte aller Gemeinden, in denen Mari\u00e4 Himmelfahrt ein Feiertag ist, kann beim Bayerischen Landesamt f\u00fcr Statistik und Datenverarbeitung heruntergeladen werden (Link siehe unter \"Weitere Weblinks\")."},"Tag der Deutschen Einheit":{"datum":"2024-10-03","hinweis":""},"Allerheiligen":{"datum":"2024-11-01","hinweis":""},"Bu\u00df- und Bettag":{"datum":"2024-11-20","hinweis":"Gem\u00e4\u00df Art. 4 Nr. 3 des Bayerischen Feiertagsgesetzes[7] entf\u00e4llt im gesamten Bundesland am Bu\u00df- und Bettag an allen Schulen der Unterricht."},"1. Weihnachtstag":{"datum":"2024-12-25","hinweis":""},"2. Weihnachtstag":{"datum":"2024-12-26","hinweis":""}}"""

    # holidayOnlyState: 

test "Full API response":
    let response: GermanFullResponse = getHolidays(year)
    check response[Bavaria].len() == 1

test "Only dates API response":
    let response: GermanOnlyDatesResponse = getOnlyDates(year)

