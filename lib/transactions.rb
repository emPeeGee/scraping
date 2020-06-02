require_relative 'transaction'

class Transactions
  attr_accessor :transactions

  def initialize(transactions)
    @transactions = transactions
  end

  def as_json
    {
        transactions: @transactions
    }
  end

  def to_json(options = {})
    as_json.to_json(options)
  end
end