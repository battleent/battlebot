# Description:
#   ddoooing
#
# Commands:
#   hubot in
#   hubot out

module.exports = (robot) ->
  robot.respond /in/i, (msg) ->
    data = {
      channel: '#ddoooing'
      username: '???'
      text: 'In'
    }
    robot.http(ENV['DDOOOING_WEBHOOK_ENDPOINT'])
      .header('Content-Type', 'application/x-www-form-urlencoded')
      .post("token=#{ENV['DDOOOING_WEBHOOK_TOKEN']}&payload=#{encodeURI(JSON.stringify(data))}") (err, response, body) ->

    msg.send "편안한 시간 되세요~"

  robot.respond /out/i, (msg) ->
    data = {
      channel: '#ddoooing'
      username: '???'
      text: 'Out'
    }
    robot.http(ENV['DDOOOING_WEBHOOK_ENDPOINT'])
      .header('Content-Type', 'application/x-www-form-urlencoded')
      .post("token=#{ENV['DDOOOING_WEBHOOK_TOKEN']}&payload=#{encodeURI(JSON.stringify(data))}") (err, response, body) ->

    msg.send "편안한 시간 되셨나요?"
