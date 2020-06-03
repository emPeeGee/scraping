require_relative 'browser_container'
require_relative 'parser'
require_relative 'accounts'

class Site < BrowserContainer
  URL = 'https://demo.bendigobank.com.au/banking/sign_in'

  def start
    @browser.goto(URL)
    @browser.button(name: 'customer_type').click

    parser = Parser.new @browser
    accounts = Accounts.new(parser.parse_accounts)

    beautiful_json = JSON.pretty_generate(JSON.parse(accounts.to_json))
    puts beautiful_json

    File.open("accounts.json", 'w') { |file| file.write(beautiful_json) }

    self.close
  end

  def close
    @browser.close
  end
end