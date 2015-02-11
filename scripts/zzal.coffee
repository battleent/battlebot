# Description:
#   whalebot 짤방
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   짤
#
# Author:
#   jiwoong

zzalbangs = [
  'https://trello-attachments.s3.amazonaws.com/54d451f89dd0df6027e328a6/240x240/504ff85f92a43dd5b519b933746c0e0c/battleduck_holiday.png',
  'https://trello-attachments.s3.amazonaws.com/54d451f89dd0df6027e328a6/240x240/d45ea4634e355e05c6e2c8c481da7b87/battleduck_yes.png',
  'https://trello-attachments.s3.amazonaws.com/54d451f89dd0df6027e328a6/240x240/98e95608ab00daa85b70536fcb592ba7/battleduck_handsome.png',
  'https://trello-attachments.s3.amazonaws.com/54d451f89dd0df6027e328a6/240x240/28813c96a70317311e798d544605aabf/battleduck_upsin.png',
  'https://trello-attachments.s3.amazonaws.com/54d451f89dd0df6027e328a6/240x240/26955df94de267e292c7cc1258eb2e4d/battleduck_sullen.png',
  'https://trello-attachments.s3.amazonaws.com/54d451f89dd0df6027e328a6/240x240/7e8b497233c6dc3b978294e2a0700242/battleduck_doom.png',
  'https://trello-attachments.s3.amazonaws.com/54d451f89dd0df6027e328a6/240x240/413ad6156534210d197cb160a9345a2f/battleduck_die.png',
  'https://trello-attachments.s3.amazonaws.com/54d451f89dd0df6027e328a6/240x240/f9bbf5bdc7cde88ba5e5fad2864fe013/battleduck_stella.png',
  'https://trello-attachments.s3.amazonaws.com/54d451f89dd0df6027e328a6/240x240/b1f2aaf02a8ab1c2b29da4d558681b21/battleduck_want.png',
  'https://trello-attachments.s3.amazonaws.com/54d451f89dd0df6027e328a6/240x240/cf9c6771be5d8c6c15cfc84e3346af62/battleduck_sulk.png'
]

module.exports = (robot) ->
  robot.hear /짤|짤방/i, (msg) ->
    msg.send msg.random zzalbangs

