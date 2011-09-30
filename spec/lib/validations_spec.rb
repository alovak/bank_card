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

  describe "validation" do
    subject { CreditCard.new }

    describe "number with Luhn algorithm" do
      before { CreditCard.validates :number, :luhn => true }

      it { should_not allow_value('123').for(:number) }
      it { should allow_value('4200000000000000').for(:number) }
    end

    describe "card expiration" do
      before { CreditCard.validates_expiration_of :date }

      it { should_not allow_value(Date.today.prev_month).for(:date) }
      it { should allow_value(Date.today).for(:date) }
    end
  end

end
