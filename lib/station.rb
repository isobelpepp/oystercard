class Station 

  def station_list
    [{ station: 'Waterloo', zone: 1 },
     { station: 'Euston', zone: 3 },
     { station: 'Putney', zone: 4 },
     { station: 'Wimbledon', zone: 6 },
     { station: 'Uxbridge', zone: 5 },
     { station: 'Baker Street', zone: 6 },
     { station: 'Oxford Circus', zone: 4 },
     { station: 'Balham', zone: 2 },
     { station: 'Paddington', zone: 1 }]
  end

  def pick_station
    station_list.sample
  end

end
