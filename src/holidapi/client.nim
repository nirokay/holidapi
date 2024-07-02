import std/[httpclient, json]
import errors

let
    http*: HttpClient = newHttpClient() ## Synchronous HTTP client

proc requestContent*(url: string): string =
    ## Synchronous request
    http.getContent(url)

proc requestJson*(url: string): JsonNode =
    ## Asynchronous request
    let content: string = url.requestContent()
    try:
        result = content.parseJson()
    except JsonParsingError:
        raise HolidAPIError.newException("Malformed API response, could not parse it to JSON.\n---begin content---\n" & content & "\n---end content---")

proc requestParsedData*[T](url: string, target: typedesc[T]): T =
    ## Requests raw text, parses to JSON and then to target `T`
    let json: JsonNode = url.requestJson()
    try:
        result = json.to(T)
    except CatchableError:
        raise HolidAPIError.newException("Could not convert 'JsonNode' to '" & $T & "' :(")
