require 'watir'
require 'nokogiri'
require './lib/site'
require 'json'
require 'neatjson'

site = Site.new Watir::Browser.new
site.start
