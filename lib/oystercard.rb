class Oystercard

  LIMIT = 90

  attr_accessor :balance

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(num)

    raise "This has exceeded the limit of £#{LIMIT}" if (@balance + num) > LIMIT

    @balance += num

  end

end
