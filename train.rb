# frozen_string_literal: true

require_relative './manufacturer'
# require_relative './instance_counter'

class Train
  include Manufacturer
  include InstanceCounter
  attr_accessor :speed
  attr_reader :carriages, :current_route, :number, :type

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i.freeze

  @@all = []

  # number == string, type == 'pass' or 'cargo'
  def initialize(number)
    register_instance
    @number = number.to_s
    @speed = 0
    validate!
    @@all << self
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def self.find(number)
    @@all.find { |train| train.number == number }
  end

  def add_carriage(carriage)
    speed_zero!
    type_carriage_validate!(carriage)
    @carriages ||= []
    @carriages << carriage
  end

  def delete_carriage(carriage)
    speed_zero!
    @carriages.delete(carriage)
  end

  def number_of_carriages
    @carriages ||= []
    @carriages.count
  end

  def each_carriage
    @carriages.map { |carriage| yield(carriage) }
  end

  def set_current_route(route)
    @current_route = route
    @current_index = 0
    @current_station = @current_route.stations[0]
    @current_station.add_train(self)
  end

  def current_station
    @current_station = current_route.stations.each do |station|
      return station if station.trains.include?(self)
    end
  end

  def next_station
    if current_index == (@current_route.stations.size - 1)
      extreme_station_valid!('end')
      @next_station = @current_route.stations[-1]
    else
      @next_station = current_route.stations[(current_index + 1)]
    end
  end

  def previous_station
    if current_index.zero?
      extreme_station_valid!('beginning')
      @previous_station = current_route.stations[0]
    else
      @previous_station = current_route.stations[current_index - 1]
    end
  end

  def go_next_station
    @current_station.send_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def go_previous_station
    @current_station.send_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
  end

  private

  def validate!
    raise 'Number is too short!' if number.length < 5
    raise 'Speed should be between 0 and 100.' unless (0..100).include?(speed)
    if number !~ NUMBER_FORMAT
      raise 'Number format: three digits or characters optional dash and two more numbers or characters.'
    end
  end

  def speed_zero!
    raise 'Speed should be zero!' unless @speed.zero?
  end

  def type_carriage_validate!(carriage)
    unless carriage.type == type
      raise 'Invalid type of carriage! Choose another carriage or train.'
    end
  end

  def extreme_station_valid!(extreme)
    raise "The train is already at the #{extreme} station!"
  end

  # current_index private, 'cause used only by methods of instance.
  def current_index
    @current_index = @current_route.stations.index(@current_station)
  end
end
