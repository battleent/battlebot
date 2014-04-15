# Description:
#   LOL 경기 결과 체크 봇.
#
# Commands:
#   hubot lol - Returns a map view of the area returned by `query`.

request = require 'request'
cheerio = require 'cheerio'

to_utf8 = (body) ->
  strContents = new Buffer(body, 'binary')
  Iconv = require('iconv').Iconv;
  iconv = new Iconv('EUC-KR', 'UTF-8')
  strContents = iconv.convert(strContents).toString()

module.exports = (robot) ->
  robot.respond /lol/i, (msg) ->

    url_to_crawl = "http://lol.inven.co.kr/dataninfo/match/teamList.php"
    request_option = {
      uri: url_to_crawl,
      encoding: 'binary'
    }
    request request_option, (err, resp, body) ->
      if err
        msg.send err

      $ = cheerio.load to_utf8(body)

      listFrame = $('#lolDbMatchTeamList .listFrame')
      listFrame.each (i, elem) ->
        listTop = $(this).find('.listTop')
        listTable = $(this).find('.listTable tbody tr')

        date = listTop.find('.date').text()
        title = listTop.find('.title').text()
        stage = listTop.find('.stage').text()
        gametime = listTop.find('.gametime').text()

        msg.send "#{date} #{title} #{stage} #{gametime}"

        listTable.each (i, elem) ->
          teamname = $($(this).find('td')[0]).text()
          winlose = $($(this).find('td')[1]).text()
          msg.send "#{teamname} - #{winlose}"

        msg.send ""

