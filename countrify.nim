import std/[strutils]

const countries: seq[string] = @[
    "Andorra",
    "Albania",
    "Armenia",
    "Argentina",
    "Austria",
    "Australia",
    "AlandIslands",
    "BosniaAndHerzegovina",
    "Barbados",
    "Belgium",
    "Bulgaria",
    "Benin",
    "Bolivia",
    "Brazil",
    "Bahamas",
    "Botswana",
    "Belarus",
    "Belize",
    "Canada",
    "Switzerland",
    "Chile",
    "China",
    "Colombia",
    "Costa Rica",
    "Cuba",
    "Cyprus",
    "Czechia",
    "Germany",
    "Denmark",
    "DominicanRepublic",
    "Ecuador",
    "Estonia",
    "Egypt",
    "Spain",
    "Finland",
    "FaroeIslands",
    "France",
    "Gabon",
    "UnitedKingdom",
    "Grenada",
    "Georgia",
    "Guernsey",
    "Gibraltar",
    "Greenland",
    "Gambia",
    "Greece",
    "Guatemala",
    "Guyana",
    "HongKong",
    "Honduras",
    "Croatia",
    "Haiti",
    "Hungary",
    "Indonesia",
    "Ireland",
    "IsleOfMan",
    "Iceland",
    "Italy",
    "Jersey",
    "Jamaica",
    "Japan",
    "SouthKorea",
    "Kazakhstan",
    "Liechtenstein",
    "Lesotho",
    "Lithuania",
    "Luxembourg",
    "Latvia",
    "Morocco",
    "Monaco",
    "Moldova",
    "Montenegro",
    "Madagascar",
    "NorthMacedonia",
    "Mongolia",
    "Montserrat",
    "Malta",
    "Mexico",
    "Mozambique",
    "Namibia",
    "Niger",
    "Nigeria",
    "Nicaragua",
    "Netherlands",
    "Norway",
    "NewZealand",
    "Panama",
    "Peru",
    "PapuaNewGuinea",
    "Poland",
    "Puerto Rico",
    "Portugal",
    "Paraguay",
    "Romania",
    "Serbia",
    "Russia",
    "Sweden",
    "Singapore",
    "Slovenia",
    "SvalbardAndJanMayen",
    "Slovakia",
    "SanMarino",
    "Suriname",
    "ElSalvador",
    "Tunisia",
    "Turkey",
    "Ukraine",
    "UnitedStates",
    "Uruguay",
    "VaticanCity",
    "Venezuela",
    "Vietnam",
    "SouthAfrica",
    "Zimbabwe"
]

let templateFile: string = readFile("src/api/nagerdate/template.nim")

for country in countries:
    let fileName: string = "src/api/nagerdate/" & country.toLower() & ".nim"
    fileName.writeFile(templateFile.replace("REPLACEME", country))