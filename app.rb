require 'watir'

browser = Watir::Browser.new

browser.goto('https://demo.bendigobank.com.au/banking/sign_in')
browser.button(name: 'customer_type').click

browser.close