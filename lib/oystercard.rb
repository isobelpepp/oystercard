require_relative 'journey'
require_relative 'station'

class Oystercard

  LIMIT = 90
  MIN = 1

  attr_accessor :balance
  attr_reader :entry_station, :exit_station, :journeys, :current_journey

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
    @entry_station = nil
    @exit_station = nil
    @current_journey = nil
  end

  def top_up(num)
    raise "This has exceeded the limit of £#{LIMIT}" if (@balance + num) > LIMIT

    @balance += num
  end

  def tap_in
    raise "Balance is below £#{MIN}" if @balance < MIN

    @entry_station = random_station

    @current_journey = Journey.new(@entry_station[:station], @entry_station[:zone])
  end

  def in_use
    !!entry_station
  end

  def tap_out
    @exit_station = random_station
    complete_journey
    deduct
    @entry_station = nil
  end

  def random_station
    station = Station.new
    station.pick_station
  end

  def complete_journey
    if @current_journey
      @current_journey
    else
      @current_journey = Journey.new
    end

    @current_journey.finish(@exit_station[:station], @exit_station[:zone])

    #@journeys << { entry_station: @entry_station[:station], exit_station: @exit_station[:station] }
  end

  private 

  def deduct(money=MIN)
    @balance -= @current_journey.fare
  end

end
