require "journey"

describe Journey do

  subject(:journey) {described_class.new(entry_station)}

  let(:entry_station) {double :station}
  let(:exit_station) {double :station}

  it "initialized with an entry station" do
    expect(journey.entry_station).to eq entry_station
  end

  describe "#finish" do
    it "stores an exit station" do
      journey.finish(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end

  describe '#fare' do
    it 'returns the minimum fare for valid journey' do
      journey.finish(exit_station)
      expect(journey.fare).to eq described_class::MINIMUM_CHARGE
    end
    it 'returns penalty charge for not touching out' do
      expect(journey.fare).to eq described_class::PENALTY_CHARGE
    end
    it 'returns penalty charge for not touching in' do
      journey.reset
      journey.finish(exit_station)
      expect(journey.fare).to eq described_class::PENALTY_CHARGE
    end


  end



end
