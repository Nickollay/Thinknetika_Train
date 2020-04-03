class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(start_station, end_station)
    register_instance
    @stations = [start_station, end_station]
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def add_way_station(station)
    @stations.insert(-2, station)
  end

  def delete_way_station(station)
    @stations.delete(station)
  end

  def to_s
    @stations.map { |station| station.name }
  end

  private

  def validate!
    raise 'Route should has at least two stations!' if @stations.length < 2
  end
end