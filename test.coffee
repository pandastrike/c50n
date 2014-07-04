{regexp, word, ws, ignore, any, all, between,
  list, delimited, rule, grammar} = require "bartlett"

_word = word
word = (s) -> all ignore(ws), _word(s)
decimal_point = word "."
integer = rule (regexp /(\d+)/), (s) -> parseInt(s)
float = all integer, decimal_point, integer
number = any integer, float


amen = require "amen"
assert = require "assert"

amen.describe "CSON parser", (context) ->
  context.test "Parse an integer", ->
    assert.equal (grammar(integer) "123"), 123
    assert.equal (grammar(integer) "abc"), null
