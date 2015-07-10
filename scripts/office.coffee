# Description:
#   Gives a random Office quote from @officequotesnet
#
# Dependencies:
#   'twit': '1.1.6'
#   'underscore': '1.4.4'
#
# Commands:
#   hubot office quote me - Show random tweet from @officequotesnet
#   hubot office bomb <n> - Show <n> random tweets from @officequotesnet
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

  officequote_says = (msg, count = 1) ->
    twit.get 'statuses/user_timeline',
      screen_name: escape('officequotesnet')
      count: 10000
      include_rts: false
      exclude_replies: true
    , (err, reply) ->
      return msg.send "Error #{err}" if err
      messages = _.sample(reply, count)
      messages.map (message) ->
        msg.send _.unescape(message['text'])

  robot.respond /office quote me/i, (msg) -> officequote_says msg

  robot.respond /office bomb( (\d+))?/i, (msg) -> officequote_says msg, msg.match[2] || 5
