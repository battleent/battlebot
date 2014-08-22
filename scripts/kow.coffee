# Description:
#   KOW
#
# Commands:
#   hubot kow - kow 주소를 알려줍니다.
#   hubot kow 오늘|어제 유니크 <query> - kow에서 query 유니크 카운트를 검색합니다.

require 'date-utils'

module.exports = (robot) ->
  robot.respond /(kow)/i, (msg) ->
    msg.send('KOW 통계는 여기에서 확인하세요. http://kow.esportsbattle.com:12000/')

  robot.respond /(kow) (오늘|어제) (유니크) (.*)/i, (msg) ->
    date_query = msg.match[2]
    query = msg.match[4]

    date = Date.today().toFormat("YYYYMMDD")
    if(/어제/.test(date_query))
      date = Date.yesterday().toFormat("YYYYMMDD")

    msg.send('kow에서 ' +date_query+ '('+date+')의 유니크 ' + query + ' 카운트를 확인합니다.')
    msg.http("http://kow.esportsbattle.com:12000/event/unique/count/sdate"+date+"/edate"+date)
      .get() (err, res, body) ->
        message = ""
        JSON.parse(body).data.eventList.forEach (event) ->
          if(event.event.name.indexOf(query) != -1)
            message += event.event.name + " : " + event.count + "명\n"

        if(message != "")
          msg.send(message)
        else
          msg.send("검색 결과가 없습니다. 다른 검색어를 알려주세요")






