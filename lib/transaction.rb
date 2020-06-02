class Transaction
  attr_accessor :date, :description, :amount, :currency, :account_name

  def initialize(date, description, amount, currency, account_name)
    @date = date
    @description = description
    @amount = amount
    @currency = currency
    @account_name = account_name
  end

  def to_s
    puts "#{date} #{description} #{amount} #{currency} #{account_name}"
  end

  def as_json(options = {})
    {
        date: @date,
        description: @description,
        amount: @amount,
        currency: @currency,
        account_name: @account_name
    }
  end

  def to_json(options = {})
    as_json(options).to_json(options)
  end
end
