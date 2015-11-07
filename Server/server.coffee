http = require 'http'
url = require 'url'
querystring = require 'querystring'
directory = require "./uci_directory.coffee"

http.createServer (req, res) ->
  _url = url.parse req.url
  if match = _url.pathname.match /^\/(.*).json$/i
    endpoint = match[1].toLowerCase()
    if directory[endpoint]
      query = querystring.parse _url.query
      console.log "#{endpoint}: #{query.query}"
      directory[endpoint] query.query, (entry) ->
        if entry
          res.writeHead 200, "Content-Type": "application/json"
          res.end JSON.stringify
            query: query.query
            data: entry
        else
          res.writeHead 404, "Content-Type": "application/json"
          res.end JSON.stringify error: "not found"

    else
      res.writeHead 502, "Content-Type": "application/json"
      res.end JSON.stringify error: "wrong API format"
.listen 1337

