# Description
#   Item aus Datenbank holen
# https://www.tutorialspoint.com/coffeescript/coffeescript_mongodb.htm
# http://theholmesoffice.com/how-to-ge-data-from-mongodb-into-node-js/
#
# https://github.com/bryanschoeff/hubot-persist-mongo
#
# Configuration:
#   MLAB_API_KEY Your Mlab Api Key
#   MLAB_USER_NAME
#   MLAB_USER_PW
#
# Commands:
#   oacitem <Nummer>
#
#
# Author:
#   Kaimodo


#mongo = require 'mongodb'
#
#server = new mongo.Server "127.0.0.1", 27017, {}
#
#client = new mongo.Db 'test', server, {w:1}
#
#exampleFind = (dbErr, collection) ->
#    console.log "Unable to access database: #{dbErr}" if dbErr
#    collection.find({ _id: "my_favorite_latte" }).nextObject (err, result) ->
#        if err
#            console.log "Unable to find record: #{err}"
#        else
#            console.log result # => {  id: "my_favorite_latte", flavor: "honeysuckle" }
#        client.close()
#
#client.open (err, database) ->
#    client.collection 'coffeescript_example', exampleFind
#
#Requiring the Mongodb package
#mongo = require 'mongodb'
mongo = require('mongodb').MongoClient


#Connecting to the server

    
module.exports = (robot) ->
    robot.hear /oac.item (.*)/i, (res) ->
        searchName = res.match[1]#.toLowerCase()
        console.log 'Eingabe: ', searchName
        mdbPw = process.env.MLAB_USER_PW
        url = 'mongodb://Kaimodo:'+mdbPw+'@ds157390.mlab.com:57390/resitems'
        mongo.connect url, (err, db) ->
            if err
                console.log 'MongoDB: Unable to connect . Error:', err
            else
                console.log 'MongoDB: Connection established to', url                    

            #Daten finden
            #col.find({ Name: /Zit/i } , {'limit':1}).toArray (err, result) ->
            #find({"FirstName": new RegExp(val)})
            db.collection('items_de.oac-head.com_2').find({ Name: new RegExp(searchName) } , {'limit':1}).toArray (err, result) ->
                if err
                    console.log err
                else
                    console.log 'Found:', result
                #Closing connection
                #db.close()

                Picurl = result[0].Picture
                bla = result[0].AllData
                console.log 'Blup :', bla

                payload = 
                    message: res.message
                        #room: "##{query.room}"
                    content:
                        text: ''
                        fallback: ''
                        pretext: ''
                        color: '#EEEEEE'
                        fields: []

                payload.content.text = "#{result[0].AllData}"

                robot.emit 'slack-attachment', payload 


              
                # https://api.slack.com/docs/message-attachments
                