# Description:
#   Allows hubot to answer almost any question by asking Wolfram Alpha
#
# Dependencies:
#   "wolfram": "0.2.2"
#
# Configuration:
#   HUBOT_WOLFRAM_APPID - your AppID
#
# Commands:
#   hubot question <question> - Searches Wolfram Alpha for the answer to the question
#
# Notes:
#   This may not work with node 0.6.x
#
# Author:
#   dhorrigan

Wolfram = require('wolfram').createClient(process.env.HUBOT_WOLFRAM_APPID)

module.exports = (robot) ->
  robot.respond /(question|wfa) (.*)$/i, (msg) ->
    Wolfram.query msg.match[2], (e, result) ->
      if result and result.length > 0
        subpods = result[1]['subpods']
        for subpod in subpods
            if subpod['value'] is '' and subpod['image']
                msg.send subpod['image']
            else
                msg.send subpod['value']
      else
        msg.send 'Hmm...not sure'
