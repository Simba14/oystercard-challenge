
describe 'User Stories' do

  let(:card) {Oystercard.new}

  # In order to use public transport
  # As a customer
  # I want money on my card
  it "so customer can use public transport, allow card to store money" do
    expect(card.return_balance).to eq 0
  end


end
