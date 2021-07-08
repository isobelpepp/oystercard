require 'station'

describe Station do

  it 'holds a list of stations and zones' do
    expect(subject.station_list).to include({ station: 'Balham', zone: 2 })
  end

  describe '#random_station' do
    it 'returns a random station and zone' do
      allow(subject).to receive(:pick_station) { {station: 'Paddington', zone: 1} }
      expect(subject.pick_station).to eq({station: 'Paddington', zone: 1})
    end
  end

end
