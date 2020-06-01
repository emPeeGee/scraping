require_relative 'account'

class Accounts
  attr_accessor :accounts

  def initialize(accounts)
    @accounts = accounts
  end

  def as_json
    {
        accounts: @accounts
    }
  end

  def to_json(options = {})
    as_json.to_json(options)
  end
end