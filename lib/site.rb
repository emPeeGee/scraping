require_relative 'browser_container'
require_relative 'parser'
require_relative 'accounts'

class Site < BrowserContainer
  URL = 'https://demo.bendigobank.com.au/banking/sign_in'

  def start
    @browser.goto(URL)
    @browser.button(name: 'customer_type').click

    list_with_accounts = @browser.element(class: 'grouped-list__group__items')

    parser = Parser.new
    accounts = Accounts.new(parser.parse_accounts(list_with_accounts))

    op = {
        :accounts => Accounts.new([])
    }

    puts accounts.to_json(op)

    self.close
  end

  def close
    @browser.close
  end
end # Site