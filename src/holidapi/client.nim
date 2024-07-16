import std/[httpclient, json, options]
import errors

let
    http*: HttpClient = newHttpClient() ## Synchronous HTTP client

proc requestContent*(url: string): Option[string] =
    ## Synchronous request
    try:
        result = some http.getContent(url)
    except HttpRequestError:
        result = none string

proc requestJson*(url: string): Option[JsonNode] =
    ## Asynchronous request
    let content: Option[string] = url.requestContent()
    try:
        result = some content.get().parseJson()
    except UnpackDefect:
        raise HolidAPIError.newException("Could not retrieve response from url '" & url & "'")
    except JsonParsingError:
        raise HolidAPIError.newException("Malformed API response, could not parse it to JSON.\n---begin content---\n" & content.get("none given") & "\n---end content---")

proc requestParsedData*[T](url: string, target: typedesc[T]): T =
    ## Requests raw text, parses to JSON and then to target `T`
    let json: Option[JsonNode] = url.requestJson()
    try:
        result = json.get().to(T)
    except UnpackDefect:
        raise HolidAPIError.newException("Could not retrieve response from url '" & url & "'")
    except CatchableError as e:
        raise HolidAPIError.newException("Failed to convert 'JsonNode' to '" & $T & "' :(\nDetails: [" & $e.name & "] " & e.msg)
