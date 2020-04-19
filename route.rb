# frozen_string_literal: true

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
  rescue StandardError
    false
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def to_s
    @stations.map(&:name)
  end

  private

  # For now this validation is redundant.
  # Cause in maine.rb there is possible to create route only with two stations.
  # And also impossible to delete last two stations in the route.
  # Maybe later somehow it helps to refactor maine.rb...
  def validate!
    raise 'Route should has at least two stations!' if @stations.length < 2
  end
end
