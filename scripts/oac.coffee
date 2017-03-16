# Description:
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
#
# Notes:
# http://qiita.com/taka0125/items/6260bc7cfc1a5f6026f1
#
# Author:
#   Kaimodo
module.exports = (robot) ->
  robot.respond /dng.t6/, (res) ->
    room = res.envelope.room
    timestamp = new Date/1000|0

    # https://api.slack.com/docs/message-attachments
    attachments = [
      {
        fallback: 'dngT6',
        color: 'good',
        pretext: 'Drops aus allen T6 Kerkern',
        fields: [
          {
            title: 'RTL Navid',
            value: 'Schulter',
            short: true
          }
          {
            title: 'RTL Alabasta',
            value: 'Kopf',
            short: true
          },
          {
            title: 'RTL LB',
            value: 'beides',
            short: true
          }
        ]        
      },{
        color: 'warning',
        fields: [
          {
            title: 'DSL',
            value: 'Hose und Schuhe',
            short: true
          }
        ]   
      },{
        color: 'danger',
        fields: [
          {
            title: 'DDL FB',
            value: 'Hand',
            short: true
          },{
            title: 'DDL LB',
            value: 'Hand & Brust',
            short: true
          }
        ]   
      },{
          fallback: 'test',
          color: 'grey',
          footer: 'resis',
          footer_icon: 'https://avatars.slack-edge.com/2017-03-09/151204178657_8ed2b3731b17d14bfdf9_48.png',
          ts: timestamp
      }
    ]

    options = { as_user: true, link_names: 1, attachments: attachments }

    client = robot.adapter.client
    client.web.chat.postMessage(room, '', options)