class Oystercard

  LIMIT = 90
  MIN = 1

  attr_accessor :balance
  attr_reader :entry_station

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(num)

    raise "This has exceeded the limit of £#{LIMIT}" if (@balance + num) > LIMIT

    @balance += num

  end

  def tap_in(entry_station)
    raise "Balance is below £#{MIN}" if @balance < MIN

    @entry_station = entry_station
  end

  def in_use
    @entry_station == nil ? false : true
  end

  def tap_out
    deduct
    @entry_station = nil
  end

  private 

  def deduct(money=MIN)
    @balance -= money
  end

end
