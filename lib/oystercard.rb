require_relative 'station'
require_relative 'journey_log'

class Oystercard 

  attr_reader :balance, :journey_log, :entry_station

  LIMIT = 90
  MIN = 1
  PENALTY_FARE = 6

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(num)
    raise "This has exceeded the limit of £#{LIMIT}" if (@balance + num) > LIMIT

    @balance += num
  end

  def random_station
    station = Station.new
    station.pick_station
  end

  def tap_in
    raise "Balance is below £#{MIN}" if @balance < MIN

    @entry_station = random_station
    new_journey_log
    deduct if @journey_log.in_journey?
    @journey_log.start(@entry_station[:station], @entry_station[:zone])
  end

  def tap_out
    @exit_station = random_station
    new_journey_log
    @journey_log.finish(@exit_station[:station], @exit_station[:zone])
    deduct
    @journey_log.add_to_log
    @entry_station = nil
  end

  # can tidy up method above??

  def deduct
    @balance -= @journey_log.fare
  end

  def new_journey_log
    @journey_log = JourneyLog.new if @journey_log.nil?
  end

end
