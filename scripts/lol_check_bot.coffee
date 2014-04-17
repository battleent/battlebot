# Description:
#   LOL 경기 결과 체크 봇.
#
# Commands:
#   hubot lol - 인벤에서 LOL 경기 결과를 검색해서 보여줍니다.

request = require 'request'
cheerio = require 'cheerio'
require 'date-utils'

to_utf8 = (body) ->
  strContents = new Buffer(body, 'binary')
  Iconv = require('iconv').Iconv;
  iconv = new Iconv('EUC-KR', 'UTF-8')
  strContents = iconv.convert(strContents).toString()

searchInven = (msg, query, callback) ->
  url_to_crawl = "http://lol.inven.co.kr/dataninfo/match/teamList.php" + query
  request_option = {
    uri: url_to_crawl,
    encoding: 'binary'
  }

  msg.send "인벤에서 정보를 검색합니다..."


  request request_option, (err, resp, body) ->
    if err
      msg.send err

    $ = cheerio.load to_utf8(body)

    listFrame = $('#lolDbMatchTeamList .listFrame')

    if listFrame.length  == 0
      msg.send "결과가 없습니다."
    listFrame.each (i, elem) ->
      listTop = $(this).find('.listTop')
      listTable = $(this).find('.listTable tbody tr')

      date = listTop.find('.date').text()
      title = listTop.find('.title').text()
      stage = listTop.find('.stage').text()
      gametime = listTop.find('.gametime').text()

      message = "#{date} #{title} 리그 #{stage} 경기\n"

      listTable.each (i, elem) ->
        teamname = $($(this).find('td')[0]).text()
        winlose = $($(this).find('td')[1]).text()

        message += "#{teamname} - #{winlose}\n"
      callback(message)


module.exports = (robot) ->
  robot.respond /lol/i, (msg) ->
    msg.send "http://lol.inven.co.kr/dataninfo/match/teamList.php"

  robot.respond /lol( today)/i, (msg) ->
    today = Date.today().toFormat("YYYY-MM-DD")
    searchInven msg, "?startDate=#{today}&endDate=#{today}", (message) ->
      msg.send message

  robot.respond /lol( yesterday)/i, (msg) ->
    yesterday = Date.yesterday().toFormat("YYYY-MM-DD")
    searchInven msg, "?startDate=#{yesterday}&endDate=#{yesterday}", (message) ->
      msg.send message



