require 'journey_log'

describe JourneyLog do

  subject(:log) {described_class.new(journey_class)}
  let(:journey_class) { double :journey_class,  :new => journey  }
  let(:journey) { double :journey, :start => entry_station, :finish => exit_station, :entry_station => entry_station, :exit_station => exit_station, :reset => nil }
  let(:entry_station) { double :entry_station}
  let(:exit_station) { double :exit_station}

describe '#initialize' do
  it 'creates a journeys array' do
    expect(log.journeys).to eq []
  end
end

describe '#start' do
  it 'creates a new journey' do
    expect(journey_class).to receive(:new)
    log.start(entry_station)
  end
end

describe '#finish' do
  it 'records an exit station and adds the journey to the journeys array' do
    log.start(entry_station)
    log.finish(exit_station)
    expect(log.journeys).to eq [{entry_station: entry_station, exit_station: exit_station}]
  end
end


end
