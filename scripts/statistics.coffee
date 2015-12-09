# Description:
#   statistics
#
# Commands:
#   hubot 통계
#   hubot 유저현황

spacing = (length) ->
  s = "                 " #17
  console.log(s.substring(0,s.length - length).length)
  s.substring(0, s.length-length)

max_length = (l1, l2, l3) ->
  max = 0
  if l1 >= l2
    max = l1
  else
    max = l2
  if max < l3
    max=l3
  max

module.exports = (robot) ->
  robot.respond /통계/i, (msg) ->
    msg.send "1. 유저현황: 전체 유저 현황\n2. show dau : 전주 대비 DAU"
    
  robot.respond /유저현황/i, (msg) ->
    robot.http("http://stat.battlecomics.co.kr/users/status.json")
      .get() (err, res, body) ->
        total_user = "#{JSON.parse(body).total_signup_user}"
        total_device = "#{JSON.parse(body).total_device}"
        today_user = "#{JSON.parse(body).today_signup_user}"
        today_device = "#{JSON.parse(body).first_visit_device_today}"
        yesterday_user = "#{JSON.parse(body).yesterday_signup_user}"
        yesterday_device = "#{JSON.parse(body).first_visit_device_yesterday}"

        len = max_length total_user.length, total_device.length, 1

        msg.send "\n*총 가입 유저*#{spacing 7}#{spacing len+total_user.length}#{total_user}\n*총 접속 단말기 수*#{spacing 10}#{spacing len+total_device.length}#{total_device}\n*오늘 가입한 유저*#{spacing 9}#{spacing len+today_user.length}#{today_user}\n*오늘 최초 접속 단말기 수*#{spacing 14}#{spacing len+today_device.length}#{today_device}\n*어제 가입한 유저*#{spacing 9}#{spacing len+yesterday_user.length}#{yesterday_user}\n*어제 최초 접속 단말기 수*#{spacing 14}#{spacing len+yesterday_device.length}#{yesterday_device}"

  robot.respond /show dau/i, (msg) ->
    robot.http("http://stat.battlecomics.co.kr/users/daily_spreadsheet.json")
      .get() (err, res, body) ->
        date = "#{JSON.parse(body).date}"
        dau = "#{JSON.parse(body).byday_app}"
        dau_7 = "#{JSON.parse(body).byday_app - JSON.parse(body).byday_app_7}"
        web_dau = "#{JSON.parse(body).byday_web}"
        web_dau_7 = "#{JSON.parse(body).byday_web - JSON.parse(body).byday_web_7}"
        install = "#{JSON.parse(body).byday_install}"
        install_7 = "#{JSON.parse(body).byday_install - JSON.parse(body).byday_install_7}"

        len = max_length dau.length, web_dau.length, install.length

        msg.send "#{date}\n*DAU*#{spacing 3}#{spacing len+dau.length}#{dau}#{spacing dau_7.length}(#{dau_7})\n*WEB DAU*#{spacing 7}#{spacing len+web_dau.length}#{web_dau}#{spacing web_dau_7.length}(#{web_dau_7})\n*INSTALL*#{spacing 7}#{spacing len+install.length}#{install}#{spacing install_7.length}(#{install_7})"
