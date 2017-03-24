require 'station'

describe Station do

  subject(:station) {described_class.new("Aldgate")}

  it "knows its name" do
    expect(station.name).to eq("Aldgate")
  end

  it "looks up stations zone from csv" do
    expect(station.zone).to eq(1)
  end

  it "raises error if invalid station name given" do
    expect{described_class.new(name: "Manchester")}.to raise_error "Access denied: invalid station"
  end
end
