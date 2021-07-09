require 'journey_log'
require 'journey'

describe JourneyLog do
 
  describe '#initialize' do
    it 'creates an instance of Journey class' do
      expect(subject.journey).to be_an_instance_of(Journey)
    end
    it 'sets an empty journey history' do
      expect(subject.journey_history).to be_empty
    end
  end

  describe '#start' do
    it 'adds entry station and zone to current journey' do
      subject.start('Waterloo', 1)
      expect(subject.current_journey).to eq({ entry_station: 'Waterloo', start_zone: 1 })
    end
  end

  describe "#finish" do
    it 'adds start and end journey to current journey' do
      subject.start('Waterloo', 1)
      subject.finish('Bakerloo', 2)
      expect(subject.current_journey).to include({ entry_station: 'Waterloo', start_zone: 1,
                                                   exit_station: 'Bakerloo', end_zone: 2 })
    end
  end

  describe '#in_journey?' do
    it 'knows if there a current journey' do
      subject.start('Waterloo', 1)
      expect(subject.in_journey?).to eq true
    end
  end

end



