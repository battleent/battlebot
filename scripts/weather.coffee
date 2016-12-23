# Description:
#   Returns weather information from Forecast.io with a sprinkling of Google maps.
#
# Configuration:
#   HUBOT_WEATHER_CELSIUS - Display in celsius
#   HUBOT_FORECAST_API_KEY - Forecast.io API Key
#
# Commands:
#   hubot weather <city> - Get the weather for a location.
#   hubot forecast <city> - Get the 3 day forecast for a location.
#
# Author:
#   markstory
#   mbmccormick
env = process.env

forecastIoUrl = 'https://api.forecast.io/forecast/' + process.env.HUBOT_FORECAST_API_KEY + '/'
googleMapUrl = 'http://maps.googleapis.com/maps/api/geocode/json'

lookupAddress = (msg, location, cb) ->
  msg.http(googleMapUrl).query(address: location, sensor: true)
    .get() (err, res, body) ->
      try
        body = JSON.parse body
        coords = body.results[0].geometry.location
      catch err
        err = "#{location}가 어딘지 모르겠어요"
        return cb(msg, null, err)
      cb(msg, coords, err)

lookupWeather = (msg, coords, err) ->
  return msg.send err if err
  return msg.send "You need to set env.HUBOT_FORECAST_API_KEY to get weather data" if not env.HUBOT_FORECAST_API_KEY

  url = forecastIoUrl + coords.lat + ',' + coords.lng

  msg.http(url).query(units: 'auto').get() (err, res, body) ->
    return msg.send '날씨 데이터를 못 받아왔습니다 ㅠㅠ' if err
    try
      body = JSON.parse body
      current = body.currently
    catch err
      return msg.send "날씨 데이터가 잘못된 것 같아요"
    humidity = (current.humidity * 100).toFixed 0
    temperature = getTemp(current.temperature)
    text = "현재 기온 #{temperature} #{current.summary}, 습도는 #{humidity}% 입니다"
    msg.send text

lookupForecast = (msg, coords, err) ->
  return msg.send err if err
  return msg.send "You need to set env.HUBOT_FORECAST_API_KEY to get weather data" if not env.HUBOT_FORECAST_API_KEY

  url = forecastIoUrl + coords.lat + ',' + coords.lng
  msg.http(url).query(units: 'ca').get() (err, res, body) ->
    return msg.send '예보 데이터를 못 받아왔습니다 ㅠㅠ' if err
    try
      body = JSON.parse body
      forecast = body.daily.data
      today = forecast[0]
      tomorrow = forecast[1]
      dayAfter = forecast[2]
    catch err
      return msg.send '예보 데이터가 잘못된 것 같아요'
    text = "The weather for:\n"

    appendText = (text, data) ->
      dateToday = new Date(data.time * 1000)
      month = dateToday.getMonth() + 1
      day = dateToday.getDate()
      humidity = (data.humidity * 100).toFixed 0
      maxTemp = getTemp data.temperatureMax
      minTemp = getTemp data.temperatureMin

      text += "#{month}/#{day} - 최고기온: #{maxTemp}, 최저기온: #{minTemp} "
      text += "#{data.summary} 습도 #{humidity}%\n"
      text

    text = appendText text, today
    text = appendText text, tomorrow
    text = appendText text, dayAfter
    msg.send text

getTemp = (c) ->
  if env.HUBOT_WEATHER_CELSIUS
    return c.toFixed(0) + "ºC"
  return ((c * 1.8) + 32).toFixed(0) + "ºF"


module.exports = (robot) ->

  robot.respond /(.*)\s날씨/i, (msg) ->
    location = msg.match[1]
    lookupAddress(msg, location, lookupWeather)

  robot.respond /(.*)\s날씨예보/i, (msg) ->
    location = msg.match[1] || "seoul"
    lookupAddress(msg, location, lookupForecast)
