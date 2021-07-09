require 'oystercard'
# require 'station'

describe Oystercard do

#   let(:station) { double :station }

  describe '#initialize' do
    it 'has balance of 0 by default' do
      expect(subject.balance).to eq 0
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

  it 'starts with nothing in journey log' do
    expect(subject.journey_log).to eq nil
  end

#   # Can I/how do I test for #random_station?

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
    it 'created a new instance of JourneyLog if none exists' do
      subject.top_up(10)
      subject.tap_in
      expect(subject.journey_log).to be_an_instance_of(JourneyLog)
    end
    it 'gives penalty charge if tapped in twice without tapping out' do
      subject.top_up(10)
      subject.tap_in
      expect{ subject.tap_in }.to change { subject.balance }.by(-Oystercard::PENALTY_FARE)
    end
    it 'adds a station and zone to the current journey in the journey log' do
      allow(subject).to receive(:random_station) { {station: 'Paddington', zone: 1} }
      subject.top_up(10)
      subject.tap_in
      expect(subject.journey_log.current_journey).to eq({entry_station: 'Paddington', start_zone: 1})
    end
  end

  describe '#tap_out' do
    it 'will set entry station and zone to nil when tapped in and out' do
      subject.top_up(10)
      subject.tap_in
      subject.tap_out
      expect(subject.journey_log.current_journey).to eq nil
    end
    it 'deducts penalty fare when tapping out and not tapped in (first time)' do
      expect { subject.tap_out }.to change { subject.balance }.by(-Oystercard::PENALTY_FARE)
    end
    it 'deducts penalty when tapped out and not in after completing journeys' do
      subject.top_up(20)
      subject.tap_in
      subject.tap_out
      expect { subject.tap_out }.to change { subject.balance }.by(-Oystercard::PENALTY_FARE)
    end
    it 'sets entry station to nil' do
      subject.top_up(10)
      subject.tap_in
      subject.tap_out
      expect(subject.entry_station).to eq nil
    end

    # is this test better to be in the JourneyLog spec? seems a bit long winded?
    it 'saves station to journey log when tapped out' do
      allow(subject).to receive(:random_station) { {station: 'Paddington', zone: 1} }
      subject.top_up(10)
      subject.tap_in
      subject.tap_out
      expect(subject.journey_log.journey_history[0][:exit_station]).to eq('Paddington')
    end
    it 'saves a station zone to journey_log when tapped out' do
      allow(subject).to receive(:random_station) { {station: 'Paddington', zone: 1} }
      subject.top_up(10)
      subject.tap_in
      subject.tap_out
      expect(subject.journey_log.journey_history[0][:end_zone]).to eq(1)
    end


#     # I feel like there is a better way to do the test below
    it 'deducts the fare based on the zones' do
      subject.top_up(Oystercard::LIMIT)
      subject.tap_in
      start_zone = subject.journey_log.current_journey[:start_zone]
      subject.tap_out
      end_zone = subject.journey_log.journey_history[-1][:end_zone]
      fare = (start_zone - end_zone).abs + Oystercard::MIN
      expect(subject.balance).to eq(Oystercard::LIMIT - fare)
    end
    it 'adds a complete journey to journey log' do
      allow(subject).to receive(:random_station) { {station: 'Paddington', zone: 1} }
      subject.top_up(20)
      subject.tap_in
      subject.tap_out
      expect(subject.journey_log.journey_history).to eq([{entry_station: 'Paddington', start_zone: 1, 
                                                          exit_station: 'Paddington', end_zone: 1}])
    end

end

end



# # Do I/how do I test for #random_station?
# # I'd like to try and add in before hooks (e.g. not to have to write .top_up(10) in '#tap_in' everytime)
#   # but can't figure out how to make it work?
# # Would you be able to put in a test/code for tapping in and then if you don't tap out within 24 hours
#   # then it gives you a penalty fare?

#         # it 'stores journeys' do
#       #   subject.top_up(10)
#       #   subject.tap_in
#       #   subject.tap_out
#       #   expect(subject.journeys).to include ( {entry_station: station, exit_station: station_2} )
#       # end
   

#       # allow it to receive paddington at the top??