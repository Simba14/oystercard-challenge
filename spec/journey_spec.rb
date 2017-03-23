require "journey"

describe Journey do

  subject(:journey) {described_class.new}
  let(:entry_station) {double :station, :zone => 3}
  let(:exit_station) {double :station, :zone => 2}

  describe '#start' do
    it "stores an entry station" do
      journey.start(entry_station)
      expect(journey.entry_station).to eq entry_station
    end
  end

  describe "#finish" do
    it "stores an exit station" do
      journey.finish(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end

  describe '#fare' do
    # it 'returns the minimum fare for valid journey' do
    #   journey.start(entry_station)
    #   journey.finish(exit_station)
    #   expect(journey.fare).to eq described_class::MINIMUM_CHARGE
    # end
    it 'returns penalty charge for not touching out' do
      expect(journey.fare).to eq described_class::PENALTY_CHARGE
    end
    it 'returns penalty charge for not touching in' do
      journey.finish(exit_station)
      expect(journey.fare).to eq described_class::PENALTY_CHARGE
    end

    it 'returns the correct fare' do
      journey.start(entry_station)
      journey.finish(exit_station)
      expect(journey.fare).to eq (described_class::MINIMUM_CHARGE + (entry_station.zone - exit_station.zone).abs)
    end

    describe '#reset' do
      it 'resets entry and exit stations to nil' do
        journey.start(entry_station)
        journey.finish(exit_station)
        journey.reset
        expect(journey.entry_station).to eq nil
      end
    end


  end



end
