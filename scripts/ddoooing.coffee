# Description:
#   statistics
#
# Commands:
#   hubot 통계
#   hubot 유저현황
#   hubot show dau
#   hubot show me the money

module.exports = (robot) ->
  robot.respond /in/i, (msg) ->
    data = {
      channel: '#ddoooing'
      username: '???'
      text: 'In'
    }
    robot.http("https://thewhalegames.slack.com/services/hooks/incoming-webhook")
      .header('Content-Type', 'application/x-www-form-urlencoded')
      .post("token=1Ow4CtIMO9jF9EUgwkz4tXfj&payload=#{encodeURI(JSON.stringify(data))}") (err, response, body) ->

    msg.send "편안한 시간 되세요~"

  robot.respond /out/i, (msg) ->
    data = {
      channel: '#ddoooing'
      username: '???'
      text: 'Out'
    }
    robot.http("https://thewhalegames.slack.com/services/hooks/incoming-webhook")
      .header('Content-Type', 'application/x-www-form-urlencoded')
      .post("token=1Ow4CtIMO9jF9EUgwkz4tXfj&payload=#{encodeURI(JSON.stringify(data))}") (err, response, body) ->

    msg.send "편안한 시간 되셨나요?"
