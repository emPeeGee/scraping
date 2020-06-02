require 'watir'
require 'nokogiri'
require './lib/site'
require 'json'

site = Site.new Watir::Browser.new
site.start
