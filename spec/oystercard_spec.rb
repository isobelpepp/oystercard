require 'oystercard'

describe Oystercard do

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
end
