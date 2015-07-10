# Description:
#   Captures all _Marvin_ commands and writes them to our central log. This is intentionally hardcoded to match on Marvin commands
#
# Dependencies:
#
# Author:
#   Fatt & DaveS

flowdock = require 'flowdock'

module.exports = (robot) ->
  if robot.adapterName == 'flowdock'
    login_email      = process.env.HUBOT_FLOWDOCK_LOGIN_EMAIL
    login_password   = process.env.HUBOT_FLOWDOCK_LOGIN_PASSWORD
    flowdock_session = new flowdock.Session(login_email, login_password)

    robot.respond /.*/, (msg) ->
      flow_id = msg.message.user.flow
      logger_content = "--USER #{msg.message.user.id}_#{msg.message.user.name} --COMMAND #{msg.message.text}"
      if flow_id
        flowdock_session.get '/flows/find', id: flow_id, (err, flow, response) ->
          robot.logger.info "#{logger_content} --URL #{flow.web_url}/messages/#{msg.message.id}"
      else
        robot.logger.info "#{logger_content} --FLOW 1-to-1"

