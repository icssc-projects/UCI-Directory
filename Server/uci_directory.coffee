ldap = require "ldapjs"

url = "ldap://ldap.service.uci.edu"

base = "ou=University of California Irvine,o=University of California, c=US"

complete = (uid, callback) ->
  if uid.replace(/\s/g, "").match /[\W_]/
    callback []
  else
    client = ldap.createClient
      url: url

    options =
      scope: "sub"
      filter: "(|(uid=#{uid}*)(displayName=#{uid}*))"
      sizeLimit: 20

    client.search base, options, (err, res) ->
      if err
        callback []
      else
        entries = []

        res.on 'searchEntry', (entry) ->
          entry.object.uid = entry.object.uid.toLowerCase()
          entries.push entry.object
        res.on 'error', (err) ->
          if (err || {}).name is 'SizeLimitExceededError'
            callback entries
          else
            callback []
        res.on 'end', (result) ->
          callback entries

lookup = (uid, callback) ->
  if uid.match /[\W_]/
    callback null
  else
    client = ldap.createClient
      url: url
    options =
      scope: "sub"
      filter: "(uid=#{uid})"

    client.search base, options, (err, res) ->
      entry = null
      if err
        callback entry
      else
        res.on 'searchEntry', (entry) ->
          callback entry.object
        res.on 'error', (err) ->
          callback entry
        res.on 'end', (status) ->
          callback entry unless entry


module.exports = {complete, lookup}
