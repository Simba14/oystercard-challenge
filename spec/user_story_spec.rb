
describe 'User Stories' do

  let(:card) {Oystercard.new}
  let(:entry_station) {double :station, :zone => 3}
  let(:exit_station) {double :station, :zone => 2}
  let(:journey_history) {{entry_station: entry_station, exit_station: exit_station}}
  let(:journey) { Journey.new}
  # In order to use public transport
  # As a customer
  # I want money on my card
  it "So customer can use public transport, allow card to store money" do
    expect(card.balance).to eq 0
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card
  it "So customer can keep using card, allow money to be loaded to card" do
    card.top_up(20)
    expect(card.balance).to eq 20
  end

  # In order to protect my money from theft or loss
  # As a customer
  # I want a maximum limit (of £90) on my card
  it "In order to protect money, enforce a maximum limit of £90 on card" do
    card.top_up(45)
    expect {card.top_up(46)}.to raise_error "Cannot top up: maximum balance exceeded (£90)"
  end

  # In order to pay for my journey
  # As a customer
  # I need my fare  deducted from my card
  it "In order to pay for journeys, deduct fare from card" do
    card.top_up(20)
    card.touch_in(entry_station)
    expect { card.touch_out(entry_station) }.to change { card.balance }.by -1
  end

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.
  it "In order to get through barriers, card is able to touch in and out" do
    card.top_up(1)
    card.touch_in(entry_station)
    expect(card.in_journey?).to be true
    card.touch_out(exit_station)
    expect(card.in_journey?).to be false
  end

  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount for a single journey
  it "In order to pay for journey, minimum amount for a single journey is needed" do
    expect{ card.touch_in(entry_station) }.to raise_error "Cannot pass. Insufficient funds!"
  end

  # In order to pay for my journey
  # As a customer
  # I need to pay for my journey when it's complete
  it "Pay for journey when complete" do
    card.top_up(1)
    card.touch_in(entry_station)
    expect {card.touch_out(exit_station)}.to change{card.balance}.by -2
  end

  # In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from
  # it "In order to pay for journey, able to know entry station" do
  #   card.top_up(1)
  #   card.touch_in(entry_station)
  #   expect( card.journey.entry_station ).to eq entry_station
  # end

  # In order to know where I have been
  # As a customer
  # I want to see to all my previous trips
  # it "I can see my journey history after completing trips" do
  #   card.top_up(1)
  #   card.touch_in(entry_station)
  #   card.touch_out(exit_station)
  #   expect(card.journey_history).to eq [journey_history]
  # end

  # In order to know how far I have travelled
  # As a customer
  # I want to know what zone a station is in
  # it "In order to know how far I have travelled, I need to know what zone a station is" do
  #
  # end

  # In order to be charged correctly
  # As a customer
  # I need a penalty charge deducted if I fail to touch in or out
  # it "Deducts penalty charge if failed to touch in or out" do
  #   penalty = 5
  #   card.top_up(20)
  #   card.touch_in(entry_station)
  #   card.touch_in(entry_station)
  #   expect(card.balance).to eq 20 - penalty
  # end

end
