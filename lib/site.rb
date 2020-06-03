require_relative 'parser'
require_relative 'accounts'

# Represents interactions|actions with the site
class Site
  URL = 'https://demo.bendigobank.com.au/banking/sign_in'

  def start
    begin
      @browser = Watir::Browser.new
      @browser.goto(URL)
      @browser.button(name: 'customer_type').click
    rescue Watir::Wait::TimeoutError => error
      puts "Some problems with loading #{error}"
    end

    parser = Parser.new(@browser)
    accounts = Accounts.new(parser.parse_accounts)

    beautiful_json = JSON.pretty_generate(JSON.parse(accounts.to_json))
    puts beautiful_json

    File.open('accounts.json', 'w') { |file| file.write(beautiful_json) }

    self.close
  end

  def close
    @browser.close
  end
end