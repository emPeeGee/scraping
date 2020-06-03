require_relative '../lib/utils'

class TestUtil
  include Utils
end

describe TestUtil do

  before(:all) do
    @utils = TestUtil.new
  end

  it 'should remove currency symbol' do
    expect(@utils.money_without_symbol("$32.42")).to eq("32.42")
    expect(@utils.money_without_symbol("$832.94")).to eq("832.94")
    expect(@utils.money_without_symbol("-$18,432.71")).to eq("-18,432.71")
    expect(@utils.money_without_symbol("-$232,323.42")).to eq("-232,323.42")
  end

  it 'should return currency symbol' do
    expect(@utils.currency_symbol("$32.42")).to eq("$")
    expect(@utils.currency_symbol("$832.94")).to eq("$")
    expect(@utils.currency_symbol("-$18,432.71")).to eq("$")
    expect(@utils.currency_symbol("-$232,323.42")).to eq("$")
  end

  it 'should return nature of account' do
    expect(@utils.nature_of_account("Everyday Account")).to eq("other_nature")
    expect(@utils.nature_of_account("Master Card")).to eq("card_nature")
    expect(@utils.nature_of_account("Home loan")).to  eq("loan_nature")
    expect(@utils.nature_of_account("Resources")).to  eq("other_nature")
    expect(@utils.nature_of_account("Term deposit")).to eq("saving_nature")
  end

  it 'should check if is debit or credit amount and return correct money' do
    expect(@utils.debit_or_credit_amount("debit", "$421,43.32")).to eq("-421,43.32")
    expect(@utils.debit_or_credit_amount("debit", "$84,43.15")).to eq("-84,43.15")
    expect(@utils.debit_or_credit_amount("credit", "$52.94")).to eq("52.94")
    expect(@utils.debit_or_credit_amount("credit", "$398,12.67")).to eq("398,12.67")
  end


end
