class Route
  attr_reader :route

  def initialize(start_station, end_station)
    @route = [start_station, end_station]
  end

  def add_way_station(station)
    @route.insert(-2, station)
  end

  def delete_way_station(station)
    @route.delete(station)
  end

  def show_route
    @route.each { |station| puts station.name}
  end
end