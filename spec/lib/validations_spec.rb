require 'spec_helper'

class CreditCard
  include ActiveModel::Validations
  include BankCard::Validations

  attr_accessor :number, :date
end

describe CreditCard do
  before { CreditCard.reset_callbacks(:validate) }

  describe "validation" do
    subject { CreditCard.new }

    describe "number with Luhn algorithm" do
      before { CreditCard.validates :number, :luhn => true }

      it { should_not allow_value('hello').for(:number) }
      it { should_not allow_value('123').for(:number) }
      it { should allow_value('4200000000000000').for(:number) }
    end

    describe "card expiration" do
      before { CreditCard.validates_expiration_of :date }

      it { should_not allow_value(Date.today.prev_month).for(:date) }
      it { should allow_value(Date.today.next_month).for(:date) }

      context "when the validity period expires in this month" do
        context "when now is first day of month" do
          before { Timecop.freeze(Date.today.beginning_of_month) }
          after  { Timecop.return }

          it { should allow_value(Date.today).for(:date) }
        end

        context "when now is last day of month" do
          before { Timecop.freeze(Date.today.end_of_month) }
          after  { Timecop.return }

          it { should allow_value(Date.today.beginning_of_month).for(:date) }
        end
      end

    end
  end

end
