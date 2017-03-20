require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

  it "initialized with a balance of 0" do
    expect(card.return_balance).to eq 0
  end

  describe "#top_up" do

    it "loads money onto card" do
      card.top_up(20)
      expect(card.return_balance).to eq 20
    end

    it "increases the returning balance by the amount loaded" do
    expect{card.top_up(20)}.to change{ card.return_balance }.by 20
    end

  end
end
