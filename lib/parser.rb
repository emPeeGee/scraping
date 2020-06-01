class Parser
  def parse_accounts(list_of_accounts)
    html_accounts = list_of_accounts.elements(css: "li")

    html_accounts.each do |li|
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

      account_currency =
          if account_balance.include? "-"
            account_balance[1, 1]
          else
            account_balance[0, 1]
          end

      puts "#{account_name} #{account_currency} #{account_balance}"
    end
  end

end