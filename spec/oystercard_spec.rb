require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

  it "initialized with a balance of 0" do
    expect(card.balance).to eq 0
  end

  describe "#top_up" do

    it "loads money onto card" do
      card.top_up(20)
      expect(card.balance).to eq 20
    end

    it "increases the returning balance by the amount loaded" do
    expect{card.top_up(20)}.to change{ card.balance }.by 20
    end

    it "raises an error if attempted top up exceeds £90 limit" do
      maximum_balance = described_class::MAXIMUM_BALANCE
      expect { card.top_up(maximum_balance+1) }.to raise_error "Cannot top up: maximum balance exceeded (£90)"
    end

    it "raises an error when balance of £90 is exceeded" do
      maximum_balance = described_class::MAXIMUM_BALANCE
      card.top_up(maximum_balance)
      expect { card.top_up(1) }.to raise_error "Cannot top up: maximum balance exceeded (£90)"
    end

  end

  describe "#deduct" do

    it "deducts fare from balance" do
      card.top_up(30)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.balance).to eq 29
    end

  end

  describe "#in_journey?" do

    it 'is in journey' do
      card.top_up(described_class::MINIMUM_BALANCE)
      card.touch_in(entry_station)
      expect(card.in_journey?).to be true
    end

    it 'is not in journey' do
      card.top_up(described_class::MINIMUM_BALANCE)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.in_journey?).to be false
    end

  end

  describe "#touch_in" do

    it "can touch in" do
      card.top_up(described_class::MINIMUM_BALANCE)
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end

    it "raises an error if there are insufficient funds" do
      expect{ card.touch_in(entry_station) }.to raise_error "Cannot pass. Insufficient funds!"
    end

    # it "records the entry station" do
    #   card.top_up(1)
    #   card.touch_in(entry_station)
    #   expect( card.journey.entry_station ).to eq entry_station
    # end

  end

  describe "#touch_out" do

    it "can touch out" do
      card.top_up(described_class::MINIMUM_BALANCE)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card).not_to be_in_journey
    end

    it "deducts fare once journey is completed" do
      card.top_up(described_class::MINIMUM_BALANCE)
      card.touch_in(entry_station)
      expect {card.touch_out(exit_station)}.to change{card.balance}.by(- Journey::MINIMUM_CHARGE)
    end

  end

  describe "#view journey history" do
    it "displays journey history" do
      card.top_up(described_class::MINIMUM_BALANCE)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.view_journey_history).to eq [{entry_station: entry_station, exit_station: exit_station}]
    end
  end

end
