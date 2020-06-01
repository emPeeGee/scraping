require_relative 'account'
require_relative 'utils'
require_relative 'world_currency'

class Parser

  def parse_accounts(list_of_accounts)
    accounts = []

    li_html_accounts = list_of_accounts.elements(css: "li")

    li_html_accounts.each do |li|
      account_name_selector = "div[data-semantic='account-name']"
      account_balance_selector = "span[data-semantic='available-balance']"

      account_name = ''
      account_balance = ''

      if li.element(css: account_name_selector).exist?
        account_name = li.element(css: account_name_selector).text.strip
      end

      if li.element(css: account_balance_selector).exist?
        account_balance = li.element(css: account_balance_selector).text.strip
      end

      account_currency = WORLD_CURRENCY[Utils.get_currency_symbol account_balance]
      account_nature = Utils.get_nature_of_account account_name
      account_balance = Utils.balance_without_symbol account_balance

      accounts.push(Account.new(account_name, account_currency, account_nature, account_balance))
    end

    accounts
  end

end