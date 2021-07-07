require 'station'

describe Station do

  let(:station) { Station.new('Euston', 1) }

  it 'knows its own name' do
    expect(station.name).to eq('Euston')
  end

  it 'knows its own zone' do
    expect(station.zone).to eq 1
  end
end
