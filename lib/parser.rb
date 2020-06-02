require_relative 'account'
require_relative 'transaction'
require_relative 'transactions'
require_relative 'utils'
require_relative 'world_currency'

class Parser < BrowserContainer

  def initialize(browser)
    super browser
    @document = Nokogiri::HTML.parse(browser.html)
  end

  def parse_accounts
    accounts = []

    list_with_accounts = @browser.element(class: 'grouped-list__group__items')
    li_html_accounts = list_with_accounts.elements(css: "li")

    li_html_accounts.each do |li_of_account|
      li_of_account.link(css: 'a').click
      sleep 3

      account_name_selector = "div[data-semantic='account-name']"
      account_balance_selector = "span[data-semantic='available-balance']"

      account_name = ''
      account_balance = ''

      if li_of_account.element(css: account_name_selector).exist?
        account_name = li_of_account.element(css: account_name_selector).text.strip
      end

      if li_of_account.element(css: account_balance_selector).exist?
        account_balance = li_of_account.element(css: account_balance_selector).text.strip
      end

      account_currency = WORLD_CURRENCY[Utils.get_currency_symbol account_balance]
      account_nature = Utils.get_nature_of_account account_name
      account_balance = Utils.balance_without_symbol account_balance

      account_transactions = parse_account_transactions(account_name)
      account_transactions.each { |tr| puts tr.to_json }
      puts "\n"

      accounts.push(Account.new(account_name, account_currency, account_nature, account_balance, Transactions.new(account_transactions)))

    end

    accounts
  end

  def parse_account_transactions(account_name)
    transactions = []
    two_months_ago = Date.today << 2

    # javascript script, check if browser is on the end of the document, if end is reached return true
    end_of_page = "if(Math.ceil(window.scrollY + window.innerHeight) >= document.querySelector('.activity-container').offsetHeight ){return true;}else{return false;}"

    until @browser.driver.execute_script(end_of_page)
      @browser.scroll.to :bottom # scroll to bottom
      wait_till_loading
    end


    group_by_date_transactions = @browser.elements(css: 'li[data-semantic="activity-group"]')
    group_by_date_transactions.each do |el|
      transaction_date = Date.parse(el.element(class: "grouped-list__group__heading").text)
      if transaction_date >= two_months_ago

        list_of_transactions_group = el.elements(css: 'li[data-semantic="activity-item"]')
        list_of_transactions_group.each do |transaction_item|

          # Where is two '<span>' we need first, which is description
          transaction_description = transaction_item.elements(class: 'overflow-ellipsis')[0].text.strip

          span_amount_with_currency = transaction_item.element(css: 'span[data-semantic="amount"]')
          amount_color = span_amount_with_currency.style("color")
          amount_with_currency = span_amount_with_currency.text

          transaction_amount = get_symbol_from_color(amount_color, amount_with_currency)
          transaction_currency = WORLD_CURRENCY[Utils.get_currency_symbol amount_with_currency]

          transactions.push(Transaction.new(transaction_date, transaction_description, transaction_amount, transaction_currency, account_name))
        end
      else
        return transactions
      end

    end

    transactions
  end

  def get_symbol_from_color(amount_color, amount_with_currency)
    case amount_color
    when "rgba(43, 43, 43, 1)"
      "-" + Utils.balance_without_symbol(amount_with_currency)
    when "rgba(30, 130, 76, 1)"
      Utils.balance_without_symbol(amount_with_currency)
    else
      ''
    end
  end

  def wait_till_loading
    @browser.div(css: 'div[data-semantic="indeterminate-loader"]').wait_while(&:present?)
  end
end