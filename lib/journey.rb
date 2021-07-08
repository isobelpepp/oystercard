require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :start_zone, :end_zone

  def initialize(entry_station = nil, start_zone = nil)
    @entry_station = entry_station
    @start_zone = start_zone
  end

  def finish(exit_station, end_zone)
    @exit_station = exit_station
    @end_zone = end_zone
    { entry_station: entry_station, start_zone: start_zone,
      exit_station: exit_station, end_zone: end_zone }
  end
  
  def fare
    if not_complete?
      PENALTY_FARE
    else
      (@end_zone - @start_zone).abs + Oystercard::MIN
    end
  end

  def not_complete?
    @entry_station == nil || @exit_station == nil
  end

end