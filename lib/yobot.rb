module Yobot
  module Behaviors
  end
end

$LOAD_PATH.unshift File.dirname(__FILE__)

require "rubygems"
require "bundler/setup"

require 'firering'
require 'json'
require 'nokogiri'
require 'meme'  
require 'logger'

require 'yobot/bot'
require 'yobot/behaviors/ping_pong'
require 'yobot/behaviors/dict'
require 'yobot/behaviors/xkcd'
require 'yobot/behaviors/image_me'
require 'yobot/behaviors/meme'
require 'yobot/behaviors/lolcats'
require 'yobot/behaviors/anaveda'
require 'yobot/behaviors/fuck_yeah'
require 'yobot/behaviors/status_report'
require 'yobot/behaviors/vasttrafik'
