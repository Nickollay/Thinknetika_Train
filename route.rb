class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_way_station(station)
    @stations.insert(-2, station)
  end

  def delete_way_station(station)
    @stations.delete(station)
  end

  def to_s
    @stations.each { |station| puts station.name}
  end
end