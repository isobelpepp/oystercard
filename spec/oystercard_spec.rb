require 'oystercard'

describe Oystercard do

  it 'responds to in_use' do
    expect(subject).to respond_to(:in_use)
  end

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

  describe '#tap_in' do
    it 'will tell you that your card is in use if you have tapped in' do
      subject.top_up(10)
      subject.tap_in
      expect(subject.in_use).to eq true
    end
    it 'raises error if card has less than £1' do
      expect { subject.tap_in }.to raise_error "Balance is below £#{Oystercard::MIN}"
    end
  end

  describe '#tap_out' do
    it 'will tell you your card is not in use if you have tapped out' do
      subject.tap_out
      expect(subject.in_use).to eq false
    end
    it 'deducts minimum fare from balance when tapping out' do
      expect { subject.tap_out }.to change { subject.balance }.by(-Oystercard::MIN)
    end
  end

end
