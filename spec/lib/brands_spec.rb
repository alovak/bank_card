require 'spec_helper'

class CreditCard
  include BankCard::Brands

  attr_accessor :number
end

describe BankCard::Brands do
  describe "detected brand" do
    let(:card)   { CreditCard.new }
    subject { card.detect_brand(number) }

    context "when card number begins with 4" do
      context "and its length 13 digits" do
        let(:number) { '4234567890123' }
        it { should == :visa }
      end

      context "and its length 16 digits" do
        let(:number) { '4200000000000000' }
        it { should == :visa }
      end

      context "and its length more than 16 digits" do
        let(:number) { '420000000000000012' }
        it { should == :visa }
      end
    end

    [34, 37].each do |card_begin|
      context "when card number begins with #{card_begin} and its length 15" do
        let(:number) { "#{card_begin}3456789012345" }
        it { should == :american_express }
      end
    end

    (51..55).each do |card_begin|
      context "when card number begins with #{card_begin} and its length 16" do
        let(:number) { "#{card_begin}34567890123456" }
        it { should == :master }
      end
    end

    (3528..3589).each do |card_begin|
      context "when card number begins with #{card_begin} and its length 16" do
        let(:number) { "#{card_begin}567890123456" }
        it { should == :jcb }
      end
    end

    (300..305).each do |card_begin|
      context "when card number begins with #{card_begin} and its length 14" do
        let(:number) { "#{card_begin}45678901234" }
        it { should == :diners_club }
      end
    end

    context "when card number begins with 36 and its length 14" do
      let(:number) { "36345678901234" }
      it { should == :diners_club }
    end

    # 6011, 622126-622925, 644-649, 65 discover
    context "when card number begins with 6011 and its length 16" do
      let(:number) { "6011567890123456" }
      it { should == :discover }
    end

    context "when card number begins with 65 and its length 16" do
      let(:number) { "6534567890123456" }
      it { should == :discover }
    end

    (644..649).each do |card_begin|
      context "when card number begins with #{card_begin} and its length 16" do
        let(:number) { "#{card_begin}4567890123456" }
        it { should == :discover }
      end
    end

    # discover begin from 622126 to 622925 and its length 16 - a lot of tests
    # tested only the boundary cases
    context "when card number begins with 622126 and its length 16" do
      let(:number) { "6221267890123456" }
      it { should == :discover }
    end
    context "when card number begins with 622129 and its length 16" do
      let(:number) { "6221297890123456" }
      it { should == :discover }
    end
    context "when card number begins with 622130 and its length 16" do
      let(:number) { "6221307890123456" }
      it { should == :discover }
    end
    context "when card number begins with 622199 and its length 16" do
      let(:number) { "6221997890123456" }
      it { should == :discover }
    end
    context "when card number begins with 622200 and its length 16" do
      let(:number) { "6222007890123456" }
      it { should == :discover }
    end
    context "when card number begins with 622899 and its length 16" do
      let(:number) { "6228997890123456" }
      it { should == :discover }
    end
    context "when card number begins with 622900 and its length 16" do
      let(:number) { "6229007890123456" }
      it { should == :discover }
    end
    context "when card number begins with 622919 and its length 16" do
      let(:number) { "6229197890123456" }
      it { should == :discover }
    end
    context "when card number begins with 622920 and its length 16" do
      let(:number) { "6229207890123456" }
      it { should == :discover }
    end
    context "when card number begins with 622925 and its length 16" do
      let(:number) { "6229257890123456" }
      it { should == :discover }
    end

    shared_examples_for "card length" do
      context "and its length 12" do
        let(:number) { "#{card_begin}#{'1'*(12 - card_begin.length)}" }
        it { should == :maestro }
      end
      context "and its length greate than 12 and less then 19" do
        let(:number) { "#{card_begin}#{'1'*(15 - card_begin.length)}" }
        it { should == :maestro }
      end
      context "and its length 19" do
        let(:number) { "#{card_begin}#{'1'*(19 - card_begin.length)}" }
        it { should == :maestro }
      end
    end

    [5018, 5020, 5038, 6304, 6759, 6761, 6762, 6763].each do |card_begin|
      context "when card number begins with #{card_begin}" do
        let(:card_begin) { card_begin.to_s }
        it_should_behave_like "card length"
      end
    end

    context "when not detect brand" do
      let(:number) { "111213131290899" }
      it { should == :unknown }
    end

  end

end
