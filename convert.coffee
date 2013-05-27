{basename} = require "path"
{createReadStream} = require "fs"
{readStream} = require "fairmont"
CSON = require "./cson"

[_,script,path] = process.argv
name = basename( script )

converters = 
  json2cson: (source) -> CSON.stringify( JSON.parse( source ) )
  cson2json: (source) -> JSON.stringify( CSON.parse( source ))

convert = (stream) -> converters[name]( readStream( stream ) )
run = (stream) -> process.stdout.write( convert( stream ) )

if path?
  stream = createReadStream( path )
  stream.on "open", -> run( stream )
else
  run( process.stdin )
