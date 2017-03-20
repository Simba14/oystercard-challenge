require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

  it "initialized with a balance of 0" do
    expect(card.return_balance).to eq 0
  end
end
