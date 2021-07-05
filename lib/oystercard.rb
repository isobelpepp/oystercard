class Oystercard

  LIMIT = 90
  MIN = 1

  attr_accessor :balance
  attr_reader :in_use

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(num)

    raise "This has exceeded the limit of £#{LIMIT}" if (@balance + num) > LIMIT

    @balance += num

  end

  def tap_in
    raise "Balance is below £#{MIN}" if @balance < MIN

    @in_use = true
  end

  def tap_out
    deduct
    @in_use = false
  end

  private 

  def deduct(money=MIN)
    @balance -= money
  end

end
