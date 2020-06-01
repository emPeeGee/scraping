require_relative 'browser_container'

class Site < BrowserContainer
  URL = 'https://demo.bendigobank.com.au/banking/sign_in'

  def start
    @browser.goto(URL)
    @browser.button(name: 'customer_type').click



    self.close
  end

  def close
    @browser.close
  end
end # Site