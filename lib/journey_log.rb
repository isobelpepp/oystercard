require_relative 'journey'

class JourneyLog

  attr_reader :current_journey, :journey

  def initialize
    @journey = Journey.new
    @journey_history = []
  end

  def journey_history
    @journey_history.dup
  end

  def start(entry_station, start_zone)
    @current_journey = @journey.start_journey(entry_station, start_zone)
  end

  def finish(exit_station, end_zone)
    tap_in_check
    @current_journey = @current_journey.merge(@journey.end_journey(exit_station, end_zone))
  end

  def add_to_log
    @journey_history << @current_journey
    @current_journey = nil
  end

  def in_journey?
    !!@current_journey
  end

  def fare
    if complete_journey
      normal_fare + 1
    else
      Oystercard::PENALTY_FARE
    end
  end

  private

  def tap_in_check
    if in_journey?
      @current_journey
    else
      @current_journey = @journey.start_journey(nil, nil)
    end
  end

  def complete_journey
    !(@current_journey[:entry_station].nil?) && @current_journey.key?(:exit_station)
  end

  def zone_difference(start_zone, end_zone)
    (start_zone - end_zone).abs
  end

  def normal_fare
    start_zone = @current_journey[:start_zone]
    end_zone = @current_journey[:end_zone]
    zone_difference(start_zone, end_zone)
    # + 1
  end

end

# I'm not sure whether some of this should be in the Journey class??

# # when you want to see journey_history try and code so that it turns out pretty