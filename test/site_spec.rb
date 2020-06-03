require 'rspec/autorun'
require_relative "../spec/spec_helper"
require_relative "../lib//site"

describe Site do

  before(:all) do
    goto 'https://demo.bendigobank.com.au/banking/sign_in'
  end

  it 'should check if sign in button is present and click it' do
    expect(button(name: 'customer_type')).to be_present
    button(name: 'customer_type').click
  end

  it 'has list of accounts' do
    expect(ol(class: 'grouped-list__group__items')).to be_present
  end

  it 'should check if container with transactions is present' do
    expect(div(css: '.activity-container')).to be_present.within(4)
  end

end
