module.exports = (robot) ->
  robot.respond /(네이버 인기만화) (\d+)(남|여)/i, (msg) ->
    msg.send('어디 봅시다...')
    age = msg.match[2]
    gender = msg.match[3]

    if gender is "남"
      if age is "10"
        search msg, "M10"
      else if age is "20"
        search msg, "M20"
      else if age is "30"
        search msg, "M30"
      else
        msg.send("??")
        help msg
    else if gender is "여"
      if age is "10"
        search msg, "W10"
      else if age is "20"
        search msg, "W20"
      else if age is "30"
        search msg, "W30"
      else
        msg.send("??")
        help msg
    else
        msg.send("??")
        help msg

help = (msg) ->
  msg.send("10남, 30여")

search = (msg, age_group) ->
  msg.http("http://comic.naver.com/recommandWebtoonRank.nhn?m=list&ageGroup=#{age_group}")
    .get() (err, res, body) ->
      for list in JSON.parse(body).list
        msg.send "#{list.rank}위 #{list.titleName} - #{list.painter}"


