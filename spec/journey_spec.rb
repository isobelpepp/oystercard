require 'journey'

describe Journey do
  it 'saves the start of a journey in a hash' do
    expect(subject.start_journey('Waterloo', 1)).to eq({ entry_station: 'Waterloo', start_zone: 1 })
  end
  it 'saves the end of a journey in a hash' do
    expect(subject.end_journey('Waterloo', 1)).to eq({ exit_station: 'Waterloo', end_zone: 1 })
  end
end

#   describe '#fare' do
#     it 'deducts a given fare for journey' do
#       journey.finish('exit', 4)
#       expect(journey.fare).to eq 4
#     end
#     it 'deducts penalty fare if journey is not complete' do
#       expect(journey.fare).to eq Journey::PENALTY_FARE
#     end
#   end 
# end