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
    robot.http("http://stat.battlecomics.co.kr/ad/profit.json?key=battlecomics_statistics")
      .get() (err, res, body) ->
        msg.send "*어제*의 띠배너 매출은:\n*쉘위애드* #{JSON.parse(body).shallwead_banner}원\n*카울리* #{JSON.parse(body).cauly_banner}원\n*매조미디어* #{JSON.parse(body).mezzo_banner}원\n*애드몹* #{JSON.parse(body).admob_banner}원\n*애드센스* #{JSON.parse(body).adsense_banner}원으로\n*총 #{JSON.parse(body).total_banner}원*입니다.\n\n*어제*의 인터스티셜 매출은:\n*카울리* #{JSON.parse(body).cauly_interstitial}원\n*매조미디어* #{JSON.parse(body).mezzo_interstitial}원으로\n*총 #{JSON.parse(body).total_interstitial}원*입니다."
