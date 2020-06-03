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
  #
  # it "allows to search" do
  #   text_field(name: "q").set "watir"
  #   button(id: "gbqfb").click
  #   results = div(id: "ires")
  #   expect(results).to be_present.within(2)
  #   expect(results.lis(class: "g").map(&:text)).to be_any { |text| text =~ /watir/ }
  #   expect(results).to be_present.during(1)
  # end
end