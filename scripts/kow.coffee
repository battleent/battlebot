# Description:
#   KOW
#
# Commands:
#   hubot kow - kow 주소를 알려줍니다.
#   hubot kow 유니크 <query> - kow에서 query 유니크 카운트를 검색합니다.

require 'date-utils'

module.exports = (robot) ->
  robot.respond /(kow)/i, (msg) ->
    msg.send('KOW 통계는 여기에서 확인하세요. http://kow.esportsbattle.com:12000/')

  robot.respond /(kow) (유니크) (.*)/i, (msg) ->
    query = msg.match[3]
    today = Date.today().toFormat("YYYYMMDD")
    msg.send('kow에서 오늘('+today+')의 유니크 ' + query + ' 카운트를 확인합니다.')
    msg.http("http://kow.esportsbattle.com:12000/event/unique/count/sdate"+today+"/edate"+today)
      .get() (err, res, body) ->
        JSON.parse(body).data.eventList.forEach (event) ->
          if(event.event.name.indexOf(query) != -1)
            msg.send(event.event.name + " : " + event.count + "명")





