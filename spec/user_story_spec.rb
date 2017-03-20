
describe 'User Stories' do

  let(:card) {Oystercard.new}

  # In order to use public transport
  # As a customer
  # I want money on my card
  it "so customer can use public transport, allow card to store money" do
    expect(card.return_balance).to eq 0
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card
  it "so customer can keep using card, allow money to be loaded to card" do
    card.top_up(20)
    expect(card.return_balance).to eq 20
  end

  

end
