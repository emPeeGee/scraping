require 'watir'
require './lib/site'

site = Site.new(Watir::Browser.new)
site.start
