assert = require "assert"
cson = require "../src/index"
{read} = require "fairmont"
{resolve} = require "path"

_test = (string) ->
  object = cson.parse string
  string = cson.stringify object
  console.log "STRINGIFY:", string
  _object = cson.parse string
  assert.deepEqual object, _object


test = (name, string) ->
  try
    _test string
    console.log name, "--pass"
  catch error
    console.log name, "--fail", "(#{error.message})"

test "Empty object literal", "{}"

test "Empty array literal", "[]"

test "Simple object literal", "{ foo: 'bar', baz: 7 }"

test "Simple array literal", "[ 1, 'b', 'c' ]"

# MOAR TESTS PLEASE!
