# #this class is responsible for only handling a journey that is currently in progress

class Journey

  PENALTY_FARE = 6

  def start_journey(entry_station, start_zone)
    { entry_station: entry_station, start_zone: start_zone }
  end

  def end_journey(exit_station, end_zone)
    { exit_station: exit_station, end_zone: end_zone }
  end

end