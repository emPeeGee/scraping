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

    puts accounts.to_json

    File.open("json.json", 'w') { |file| file.write(accounts.to_json) }

    self.close
  end

  def close
    @browser.close
  end
end # Site