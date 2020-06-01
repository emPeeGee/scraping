class Account
  attr_accessor :name,:currency, :nature, :balance, :transactions

  def initialize(name, currency, nature, balance, transactions = [])
    @name = name
    @currency = currency
    @nature = nature
    @balance = balance
    @transactions = transactions
  end

  def to_s
    puts "#{name} #{currency} #{nature} #{balance} #{transactions}"
  end
end