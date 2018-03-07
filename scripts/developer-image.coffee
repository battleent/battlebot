ENV = process.env

image = {
  merge: 'http://images.battlecomics.co.kr/dev/users/655777/page/item/6af8ba4a-4ec1-4bb8-a599-ddf4677588aa.jpg'
}

module.exports = (robot) ->
  robot.respond /merge/i, (msg) ->
    msg.send image['merge']
