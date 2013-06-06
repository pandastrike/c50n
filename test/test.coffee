cson = require "../cson"
{read} = require "fairmont"
{resolve} = require "path"

test1 = (cson.stringify (cson.parse (read resolve __dirname, "./test.cson")))
console.log test1


test2 = (cson.stringify (cson.parse (read resolve __dirname, "./test2.cson")))
console.log test2

cson.parse(test2)