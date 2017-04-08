# Description
#   Item aus Datenbank holen
#
# Configuration:
#   None needed. 
#
# Commands:
#   reshead <Nummer>
#
#
# Author:
#   Kaimodo

module.exports = (robot) ->

  robot.hear /reshead (.*)/i, (response) ->
    artistName = response.match[1].toLowerCase()
    if artistName is "Kaimodo"
      response.send "Item Nr 1-8800"
    else
      searchName = artistName.replace(" ", "+")
      robot.http("https://resishead.firebaseio.com/#{searchName}.json")
        .get() (err, res, body) ->
          if err
            response.send "Oh noes! #{err}"
            return
          data = JSON.parse body
response.send "#{data.url.items[0]}"