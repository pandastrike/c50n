{basename} = require "path"
{read} = require "fairmont"
CSON = require "./cson"

[_,script,path] = process.argv
name = basename( script )

converters =
  json2cson: (source) -> CSON.stringify( JSON.parse( source ) )
  cson2json: (source) -> JSON.stringify( CSON.parse( source ))

convert = (source) -> converters[name](source)
run = (source) -> process.stdout.write(convert(source))

try
  if path?
    run(read(path))
  else
    {stdin} = process
    source = ""
    stdin.resume()
    stdin.on "data", (data) ->
      source += data.toString("utf-8")
    stdin.on "end", ->
      run(source)
catch error
  console.error error.message
