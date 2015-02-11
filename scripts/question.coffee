# Description:
#   whalebot은 다 알아요
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   ?
#
# Author:
#   jiwoong

answers = [
  '예',
  '아니요',
  '몰라요',
  '글쎄요.. 나라고 뭐 다 알겠습니까?',
  'http://google.com 찾아보세요-_-',
  '운동이나 갑시다',
  '올 때 메로나~',
  '눼~눼~',
  '진짜?'
]

module.exports = (robot) ->
  robot.hear /(.*)\?$/i, (msg) ->
    msg.send msg.random answers

