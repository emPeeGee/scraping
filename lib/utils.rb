# Module with diverse methods which do some operations basically with string
module Utils

  # Returns currency symbol
  def currency_symbol(money)
    if money.start_with? '-'
      money[1, 1]
    else
      money[0, 1]
    end
  end

  # Returns nature of account, based on account's name
  def nature_of_account(name)
    name = name.downcase

    case
    when (name.include? 'saving') || (name.include? 'deposit')
      'saving_nature'
    when (name.include? 'card')
      'card_nature'
    when (name.include? 'loan')
      'loan_nature'
    else
      'other_nature'
    end
  end

  # Returns the money without currency symbol
  def money_without_symbol(money)
    if money[1].match(/[0-9]/)
      money[1..-1]
    else
      # Slice till first digit
      "-#{money[(money.index(/[0-9]/))..-1]}"
    end
  end

  # Checks if html include debit or credit and returns correct money symbol
  def debit_or_credit_amount(amount_html, amount_with_currency)
    if amount_html.to_s.include? 'debit'
      "-#{money_without_symbol(amount_with_currency)}"
    else
      money_without_symbol(amount_with_currency)
    end
  end

end
