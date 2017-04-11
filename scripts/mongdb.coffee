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

                pPicture = String(result[0].Picture)
                pAllData = String(result[0].AllData)
                pName = String(result[0].Name)
                console.log 'Blup :', bla

                room= res.envelope.room
                timestamp= new Date/1000|0 
                
                payload = 
                    
                    #channel: res.message.user.name
                    #username: robot.name
                    icon_url: 'icon_url'
                    #icon_url: 'https://slack.global.ssl.fastly.net/9fa2/img/services/hubot_128.png'
                    content:
                        text: 'text'
                        fallback: 'fallback'
                        pretext: 'Pretext'
                        img_url: 'img_url'
                        color: '#EEEEEE'
                        fields: []

                payload.content.pretext = pName
                payload.content.text = pAllData
                payload.content.img_url = pPicture

                options = { as_user: true, link_names: 1, attachments: payload }

                client = robot.adapter.client
                client.web.chat.postMessage(room, '', options)


              
                # https://api.slack.com/docs/message-attachments
                