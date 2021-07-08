require 'journey'

describe Journey do

  let(:station) { double :station }
  let(:station2) { double :station2 }
  let(:journey) { Journey.new(station, 1) }

  it 'knows if a journey is not complete' do
    expect(journey.not_complete?).to eq true
  end

  it 'knows if a journey is complete' do
    journey.finish('exit', 3)
    expect(journey.not_complete?).to eq false
  end

  it 'saves entry station when initiated' do
    expect(journey.entry_station).to eq station
  end

  it 'saves default nil to entry station if none entered' do
    expect(subject.entry_station).to eq nil
  end

  describe '#finish' do
    it 'returns a completed journey' do
      expect(journey.finish(station2, 1)).to eq({ entry_station: station, start_zone: 1,
                                                   exit_station: station2, end_zone: 1 })
    end
  end

  describe '#fare' do
    it 'deducts a given fare for journey' do
      journey.finish('exit', 4)
      expect(journey.fare).to eq 4
    end
    it 'deducts penalty fare if journey is not complete' do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end 
end