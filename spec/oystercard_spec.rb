require 'oystercard'
require 'station'

describe Oystercard do

  let(:station) { double :station }

  describe '#initialize' do
    it 'has balance of 0 by default' do
      expect(subject.balance).to eq 0
    end
    it 'sets entry station to nil' do
      expect(subject.entry_station).to eq nil
    end
    it 'sets exit station to nil' do
      expect(subject.exit_station).to eq nil
    end
  end

  describe '#top_up' do
    it 'tops up the balance' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end
    it 'throws an error if you try to top up more than £90' do
      expect { subject.top_up(100) }.to raise_error "This has exceeded the limit of £#{Oystercard::LIMIT}"
    end
  end

  describe '#tap_in' do
    it 'raises error if card has less than £1' do
      expect { subject.tap_in }.to raise_error "Balance is below £#{Oystercard::MIN}"
    end
    it 'sets a station when tapped in' do
      allow(subject).to receive(:random_station) { {station: 'Paddington', zone: 1} }
      subject.top_up(10)
      subject.tap_in
      expect(subject.entry_station[:station]).to eq('Paddington')
    end
    it 'sets a station zone when tapped in' do
      allow(subject).to receive(:random_station) { {station: 'Paddington', zone: 1} }
      subject.top_up(10)
      subject.tap_in
      expect(subject.entry_station[:zone]).to eq(1)
    end
    it 'stores an instance of Journey in current journey' do
      subject.top_up(10)
      subject.tap_in
      expect(subject.current_journey).to be_an_instance_of(Journey)
    end
  end

  describe '#in_use' do
    it 'will tell you that your card is in use if you have tapped in' do
      subject.top_up(10)
      subject.tap_in
      expect(subject.in_use).to eq true
    end
  end

  describe '#tap_out' do
    it 'will tell you your card is not in use if you have tapped out' do
      subject.tap_out
      expect(subject.in_use).to eq false
    end
    it 'deducts penalty fare when tapping out and not tapped in' do
      expect { subject.tap_out }.to change { subject.balance }.by(-Journey::PENALTY_FARE)
    end
    it 'sets entry station to nil' do
      subject.top_up(10)
      subject.tap_in
      subject.tap_out
      expect(subject.entry_station).to eq nil
    end
    it 'begins with an empty array' do
      expect(subject.journeys).to be_empty
    end
    it 'sets a station when tapped out' do
      allow(subject).to receive(:random_station) { {station: 'Paddington', zone: 1} }
      subject.top_up(10)
      subject.tap_out
      expect(subject.exit_station[:station]).to eq('Paddington')
    end
    it 'sets a station zone when tapped out' do
      allow(subject).to receive(:random_station) { {station: 'Paddington', zone: 1} }
      subject.top_up(10)
      subject.tap_out
      expect(subject.exit_station[:zone]).to eq(1)
    end
    # I feel like there is a better way to do the test below
    it 'deducts the fare based on the zones' do
      subject.top_up(Oystercard::LIMIT)
      subject.tap_in
      start_zone = subject.current_journey.start_zone
      subject.tap_out
      end_zone = subject.current_journey.end_zone
      fare = (start_zone - end_zone).abs + Oystercard::MIN
      expect(subject.balance).to eq(Oystercard::LIMIT - fare)
    end
  end

  describe '#complete_journey' do
    it 'adds an exit station to current_journey' do
      allow(subject).to receive(:random_station) { {station: 'Paddington', zone: 1} }
      subject.tap_out
      expect(subject.current_journey.exit_station).to eq('Paddington')
    end
    it 'adds a zone to current_journey' do
      allow(subject).to receive(:random_station) { {station: 'Paddington', zone: 1} }
      subject.tap_out
      expect(subject.current_journey.end_zone).to eq(1)
    end
    it 'sets entry station to nil if not tapped in' do
      subject.tap_out
      expect(subject.current_journey.entry_station).to eq nil
    end
    it 'sets entry zone to nil if not tapped in' do
      subject.tap_out
      expect(subject.current_journey.start_zone).to eq nil
    end
  end
end



# Do I/how do I test for #random_station?
# I'd like to try and add in before hooks (e.g. not to have to write .top_up(10) in '#tap_in' everytime)
  # but can't figure out how to make it work?

        # it 'stores journeys' do
      #   subject.top_up(10)
      #   subject.tap_in
      #   subject.tap_out
      #   expect(subject.journeys).to include ( {entry_station: station, exit_station: station_2} )
      # end
   