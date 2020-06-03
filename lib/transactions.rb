require_relative 'transaction'

# Data class, represents all transactions
class Transactions
  attr_accessor :transactions

  def initialize(transactions)
    @transactions = transactions
  end

  def to_a
    @transactions.to_a
  end
end