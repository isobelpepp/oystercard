class Oystercard

  LIMIT = 90

  attr_accessor :balance
  attr_reader :in_use

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(num)

    raise "This has exceeded the limit of £#{LIMIT}" if (@balance + num) > LIMIT

    @balance += num

  end

  def deduct(money)
    @balance -= money
  end

  def tap_in
    @in_use = true
  end

  def tap_out
    @in_use = false
  end

end
