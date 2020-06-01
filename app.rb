require 'watir'
require './lib/site'
require 'json'

site = Site.new(Watir::Browser.new)
site.start
