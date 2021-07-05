require 'oystercard'

describe Oystercard do

  describe '#initialize' do
    it 'has balance of 0 by default' do
      expect(subject.balance).to eq 0
    end
  end
end
