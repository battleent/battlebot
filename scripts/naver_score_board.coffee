# Description:
#   네이버 스코어 보드 링크 스크립트
#
# Commands:
#   hubot 네이버 스코어보드 - 네이버 스코어보드 링크를 보여줍니다.

require 'date-utils'

module.exports = (robot) ->
  robot.respond /네이버 스코어보드/i, (msg) ->
    msg.send "네이버 스코어보드는 여기로 가세요~"
    msg.send "http://sports.news.naver.com/main/scoreboard.nhn"
