CoffeeScript = window?.CoffeeScript
CoffeeScript ?= require "coffee-script"

{type} = require "fairmont"
parse = do ->
  {regexp, word, any, all, between,
    list, delimited, rule} = require "bartlett"

  _word = word
  word = (s) -> all ignore(ws), _word(s)
  decimal_point = word "."
  comma = word ","
  colon = word ":"
  braces = open: word "{", close: word "}"
  brackets = open: word "[", close: word "]"
  squote = word "'"
  dquote = word '"'
  escape = word "\\"
  escaped_dquote = all escape, squote
  escaped_dquote = all escape, dquote
  not_squote = any (except squote), escaped_squote
  not_dquote = any (except dquote), escaped_dquote
  squoted = between squote, (list not_squote)
  dquoted = between dquote, (list not_dquote)
  string = any squoted, dquoted
  integer = regexp /\d+/
  float = all integer decimal_point integer
  number = any integer, float
  date = # TODO
  _null = word "null"
  value = any string, number, date, _null, array, object
  inline_values = delimited comma, value
  property = all key, colon, value
  inline_properties = delimited comma, property
  inline_object = between braces, inline_properties

  idented = do ->
    level = 0
    (s) ->
      # TODO

  indented_property = indented property
  indented_properties = list indented_property
  indented_object = indented indented_properties
  object = any inline_object, indented_object

  idented_value = indent value
  idented_values = list indented_value
  values = any inline_values, indented_values
  array = between brackets, values
  parser = rule (any object, array)

  (source) -> parser(source)


quote = (string) ->
  "'" + (string.replace /'/g, "\\'") + "'"

property = (key,value) ->
  key = if key.match /^[\w_]+$/
    key
  else
    quote key

  "#{key}: #{value}"

_stringify = (object, options={}) ->

  {indent} = options
  outer = indent or ""
  inner = outer + "  "

  switch type object

    when "object"
      properties = do ->
        for key, value of object
          property( key, _stringify( value, indent: inner) )
      if properties.length > 0
        properties = properties.join("\n#{outer}")
        "\n#{outer}#{properties}\n#{outer}"
      else
        "{}"

    when "array"
      elements = do ->
        for element in object
          _stringify( element, indent: inner)
      if elements.length > 0
        elements = elements.join("\n#{outer}")
        "[\n#{outer}#{elements}\n#{outer}]"
      else
        "[]"

    when "string"
      quote object.toString()

    when "function"
      ;

    when "null" then "null"
    when "undefined" then "undefined"

    else
      object.toString()


stringify = (object) -> (_stringify object)[1..-1]

module.exports =
  parse: parse
  stringify: stringify
