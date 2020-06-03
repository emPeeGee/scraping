require_relative 'account'
require_relative 'transaction'
require_relative 'transactions'
require_relative 'utils'
require_relative 'world_currency'

class Parser < BrowserContainer

  include Utils

  def parse_accounts
    accounts = []

    # Find first section of accounts
    accounts_container = @browser.element(class: 'grouped-list__group__items')

    # Get every account from container and iterate over
    account_rows = accounts_container.elements(css: "li")
    account_rows.each do |account_row|
      account_row.link(css: 'a').click

      # Wait till transactions are loaded and when continue parsing
      # Not always work correct
      # @browser.div(class: 'activity-container').wait_until(&:present?)

      # Wait till transactions are loaded and when continue parsing
      sleep 3

      # Refresh Nokogiri after every account change
      @document = Nokogiri::HTML.parse(account_row.html)

      account_name = @document.at_css("div[data-semantic='account-name']").content.strip
      account_balance_unprocessed = @document.at_css("span[data-semantic='available-balance']").content.strip

      # Get currency symbol and after get correct currency from hash with all currency
      account_currency = WORLD_CURRENCY[currency_symbol(account_balance_unprocessed)]

      # Get money without currency symbol and convert it to float
      account_balance = to_float(money_without_symbol(account_balance_unprocessed))

      account_nature = nature_of_account(account_name)
      account_transactions = parse_account_transactions(account_name)

      accounts.push(
          Account.new(
            account_name,
            account_currency,
            account_nature,
            account_balance,
            Transactions.new(account_transactions)
          )
      )
    end

    accounts
  end


  private


  def parse_account_transactions(account_name)
    transactions = []
    two_months_ago = Date.today << 2

    # Javascript script, check if browser is on the end of the document, if end is reached return true
    end_of_page = "if(Math.ceil(window.scrollY + window.innerHeight) >= " +
        "document.querySelector('.activity-container').offsetHeight)" +
        " { return true; } else { return false; }"

    # Scroll till are not more transactions
    until @browser.driver.execute_script(end_of_page)
      @browser.scroll.to :bottom # scroll to bottom

      # Wait till new transactions are loaded
      @browser.div(css: 'div[data-semantic="indeterminate-loader"]').wait_while(&:present?)
    end

    # Update Nokogiri after all transactions are loaded
    @document = Nokogiri::HTML.parse(@browser.html)

    transactions_with_same_date = @document.css('li[data-semantic="activity-group"]')
    transactions_with_same_date.each do |this_day_transactions|

      transaction_date = Date.parse(this_day_transactions.at_css(".grouped-list__group__heading").content.strip)

      # If transactions are fresh
      if transaction_date >= two_months_ago

        transaction_rows = this_day_transactions.css('li[data-semantic="activity-item"]')
        transaction_rows.each do |transaction_row|

          # Where is two '<span>' with same class we need first, which is description
          transaction_description = transaction_row.at_css('.overflow-ellipsis').content.strip

          amount_html = transaction_row.at_css('span[data-semantic="amount"]')
          amount_with_currency = amount_html.content.strip

          # Get money without currency symbol and convert it to float
          transaction_amount = to_float(debit_or_credit_amount(amount_html, amount_with_currency))

          # Get currency symbol and after get correct currency from hash with all currency
          transaction_currency = WORLD_CURRENCY[currency_symbol(amount_with_currency)]

          transactions.push(
              Transaction.new(
                transaction_date,
                transaction_description,
                transaction_amount,
                transaction_currency,
                account_name
              )
          )
        end
      else
        return transactions
      end
    end

    transactions
  end

  def to_float(money)
    money.sub(',', '_').to_f
  end
end