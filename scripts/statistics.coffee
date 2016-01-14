# Description:
#   statistics
#
# Commands:
#   hubot 통계
#   hubot 유저현황
#   hubot show dau
#   hubot show me the money

module.exports = (robot) ->
  robot.respond /통계/i, (msg) ->
    msg.send "다음의 기능을 제공합니다\n1. *whalebot 유저현황:* 전체 유저 현황\n2. *whalebot show dau:* 전주 대비 DAU\n3. *whalebot show me the money:* 어제의 광고 수익"
    
  robot.respond /유저현황/i, (msg) ->
    robot.http("http://stat.battlecomics.co.kr/users/status.json?key=battlecomics_statistics")
      .get() (err, res, body) ->
        total_user = "#{JSON.parse(body).total_signup_user}"
        total_device = "#{JSON.parse(body).total_device}"
        today_user = "#{JSON.parse(body).today_signup_user}"
        today_device = "#{JSON.parse(body).first_visit_device_today}"
        yesterday_user = "#{JSON.parse(body).yesterday_signup_user}"
        yesterday_device = "#{JSON.parse(body).first_visit_device_yesterday}"

        msg.send "*총 가입 유저* #{total_user}\n*총 접속 단말기 수* #{total_device}\n*오늘 가입한 유저* #{today_user}\n*오늘 최초 접속 단말기 수* #{today_device}\n*어제 가입한 유저* #{yesterday_user}\n*어제 최초 접속 단말기 수* #{yesterday_device}"

  robot.respond /show dau/i, (msg) ->
    robot.http("http://stat.battlecomics.co.kr/users/daily_spreadsheet.json?key=battlecomics_statistics")
      .get() (err, res, body) ->
        date = "#{JSON.parse(body).date}"
        dau = "#{JSON.parse(body).byday_app}"
        dau_7 = "#{JSON.parse(body).byday_app - JSON.parse(body).byday_app_7}"
        web_dau = "#{JSON.parse(body).byday_web}"
        web_dau_7 = "#{JSON.parse(body).byday_web - JSON.parse(body).byday_web_7}"
        install = "#{JSON.parse(body).byday_install}"
        install_7 = "#{JSON.parse(body).byday_install - JSON.parse(body).byday_install_7}"

        msg.send "*#{date}의 일간 주요 수치*\n*DAU* #{dau} (#{dau_7})\n*WEB DAU* #{web_dau} (#{web_dau_7})\n*INSTALL* #{install} (#{install_7})"

  robot.respond /show me the money/i, (msg) ->
    robot.http("http://stat.battlecomics.co.kr/platforms/total.json?key=battlecomics_statistics")
      .get() (err, res, body) ->
        msg.send "#{JSON.parse(body).date}\nAPP DAU #{JSON.parse(body).app_dau} 명\nAPP WAU #{JSON.parse(body).app_wau} 명\nAPP MAU #{JSON.parse(body).app_mau} 명\nWEB DAU #{JSON.parse(body).web_dau} 명\nWEB WAU #{JSON.parse(body).web_wau} 명\nWEB MAU #{JSON.parse(body).web_mau} 명\n전체 DAU #{JSON.parse(body).total_dau} 명\n전체 WAU #{JSON.parse(body).total_wau} 명\n전체 MAU #{JSON.parse(body).total_mau} 명\nAOS 매출 #{JSON.parse(body).aos_profit} 원\nIOS 매출 #{JSON.parse(body).ios_profit} 원\nWEB 매출 #{JSON.parse(body).web_profit} 원\n전체 매출 #{JSON.parse(body).total_profit} 원"
