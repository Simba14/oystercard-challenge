
describe 'User Stories' do

  let(:card) {Oystercard.new}

  # In order to use public transport
  # As a customer
  # I want money on my card
  it "so customer can use public transport, allow card to store money" do
    expect(card.balance).to eq 0
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card
  it "so customer can keep using card, allow money to be loaded to card" do
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


end
