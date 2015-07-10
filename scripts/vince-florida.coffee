# Description:
#   Asks if Vince is the FloridaMan
#
# Dependencies:
#   'twit': '1.1.6'
#   'underscore': '1.4.4'
#
# Commands:
#   hubot is vince the florida man - Show random tweet from @_FloridaMan
#
# Author:
#   domingusj

_ = require 'underscore'
Twit = require 'twit'
config =
  consumer_key: 'bCEBOb0l73eIU0wI0MjqxY04V'
  consumer_secret: 'zjzUQTv6vCwsTmn6oEhdsaZcFYiZmO3weXGlTaPnMH3veyHWbE'
  access_token: '487895536-aARjpLIjhO1S1nGl58z4oOpKPeWZqOPAikh3OL4j'
  access_token_secret: 'Bhcz41Z2Do7IHZfHT29ZH2Hj1d88cCPyLYakqoyHR0cCM'

module.exports = (robot) ->
  twit = new Twit config

  floridaman_says = (msg, count = 1) ->
    twit.get 'statuses/user_timeline',
      screen_name: escape('_FloridaMan')
      count: 10000
      include_rts: false
      exclude_replies: true
    , (err, reply) ->
      return msg.send "Error #{err}" if err
      messages = _.sample(reply, count)
      messages.map (message) ->
        msg.send _.unescape(message['text'])

  robot.respond /is vince the florida man/i, (msg) -> floridaman_says msg


