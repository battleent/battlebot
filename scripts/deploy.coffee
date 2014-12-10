# Description:
#   Deploy commands.
#
# Commands:
#   hubot apps - OpsWorks 앱 리스트를 보여줍니다
#   hubot deploy <app> - <app>을 배포합니다
#   hubot deploy-status <app> (num) - 최근 (num) 개의 배포 상태를 보여줍니다

OpsWorks = require("../lib/opsworks")
_        = require('underscore')
Q        = require('q')

module.exports = (robot) ->
  face = {
    normal:  '(´-ω-)'
    success: '(*´▽｀*)'
    failure: '(PД`q｡)'
  }

  robot.respond /APPS/i, (msg) ->
    msg.send "OpsWorks에 올라가있는 앱 리스트를 확인합니다..."
    OpsWorks.getApps()
      .fail (err) ->
        msg.send "오류가 발생했습니다 #{face.failure} #{err.message}"
      .then (apps) ->
        msg.send apps.join(" ")

  robot.respond /DEPLOY (.*)$/i, (msg) ->
    app = msg.match[1]
    msg.send "#{app}을 배포합니다..."
    OpsWorks.use(app)
    .fail (err) ->
      msg.send "오류가 발생했습니다 #{face.failure} #{err.message}"
    .then (app) ->
      app.deploy().then (result) ->
        if result.DeploymentId
          msg.send "배포했습니다 #{face.success} https://console.aws.amazon.com/opsworks/home?#/stack/#{app.StackId}/deployments/#{result.DeploymentId}"
        else
          msg.send "배포할 수 없습니다 #{face.failure}"


  robot.respond /DEPLOY[_\-]STATUS ([^ ]+)( ([0-9]+))?$/i, (msg) ->
    app = msg.match[1]
    num = msg.match[2]
    num -= 1 if num
    msg.send "#{app}의 배포상태를 확인합니다..."
    OpsWorks.use(app)
    .fail (err) ->
      msg.send "오류가 발생했습니다 #{face.failure} #{err.message}"
    .then (app) ->
      app.deployStatus(num).then (deploys) ->
        for deploy in deploys
          trans = {
            running:    "배포 중이에요 #{face.normal}"
            successful: "배포가 끝났습니다 #{face.success}"
            failed:     "배포가 실패했습니다 #{face.failure}"}
          status = trans[deploy.Status]
          msg.send "#{status} https://console.aws.amazon.com/opsworks/home?#/stack/#{deploy.StackId}/deployments/#{deploy.DeploymentId}"

