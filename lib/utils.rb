class Utils

  # Util method, return currency symbol
  def self.get_currency_symbol(balance)
    if balance.start_with? "-"
      balance[1, 1]
    else
      balance[0, 1]
    end
  end

  # Util method, return nature of account, based on account's name
  def self.get_nature_of_account(name)
    name = name.downcase

    case
      when (name.include? "saving") || (name.include? "deposit")
        "saving_nature"
      when (name.include? "card")
        "card_nature"
      when (name.include? "loan")
        "loan_nature"
      else
        "basic_nature"
      end
  end


  # Util method, return the balance without symbol
  def self.balance_without_symbol(balance)
    if balance.start_with? "-"
      balance[0] + balance[2..-1]
    else
      balance[1..-1]
    end
  end

end