require 'spec_helper'

class CreditCard
  include ActiveModel::Validations
  include BankCard::Validations

  attr_accessor :number, :date
end

describe CreditCard do
  before do 
    CreditCard.reset_callbacks(:validate)
  end

  it "should validate number with Luhn algorithm" do
    CreditCard.validates :number, :luhn => true
    card = CreditCard.new

    card.number = '123'
    card.should be_invalid
    card.errors[:number].should include("is invalid")

    card.number = '4200000000000000'
    card.should be_valid
  end

  it "should validate card expiration" do
    CreditCard.validates_expiration_of :date
    card = CreditCard.new
  
    card.date = Date.today.prev_month
    card.should be_invalid
    card.errors[:date].should include("is expired")

    card.date = Date.today
    card.should be_valid
  end
end
