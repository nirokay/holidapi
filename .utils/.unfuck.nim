import std/[os, strutils]

const remove: string = " preferred langauge (english as fallback) "

for kind, path in walkDir("src/holidapi/api/nagerdate/"):
    let
        before: string = readFile(path)
        after: string = before.replace(remove, " ")
    path.writeFile(after)
