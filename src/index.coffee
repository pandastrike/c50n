{parse, stringify} = require "cson-safe"
#
# We're using cson-safe's stringify until we can test this properly.
#
#
# {type} = require "fairmont"
#
# quote = (string) ->
#   "'" + (string.replace /'/g, "\\'") + "'"
#
# property = (key,value) ->
#   key = if key.match /^[\w_]+$/
#     key
#   else
#     quote key
#
#   "#{key}: #{value}"
#
# _stringify = (object, options={}) ->
#
#   {indent} = options
#   outer = indent or ""
#   inner = outer + "  "
#
#   switch type object
#
#     when "object"
#       properties = do ->
#         for key, value of object
#           property( key, _stringify( value, indent: inner) )
#       if properties.length > 0
#         properties = properties.join("\n#{outer}")
#         "\n#{outer}#{properties}\n#{outer}"
#       else
#         "{}"
#
#     when "array"
#       elements = do ->
#         for element in object
#           _stringify( element, indent: inner)
#       if elements.length > 0
#         elements = elements.join("\n#{outer}")
#         "[\n#{outer}#{elements}\n#{outer}]"
#       else
#         "[]"
#
#     when "string"
#       inner + quote object.toString()
#
#     when "function"
#       ;
#
#     when "null" then "null"
#     when "undefined" then "undefined"
#
#     else
#       inner + object.toString()
#
#
# stringify = (object) -> _stringify object

module.exports = { parse, stringify }
