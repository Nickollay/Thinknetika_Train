require_relative './manufacturer'

class Train
  include Manufacturer
  attr_accessor :speed
  attr_reader :carriages, :current_route, :number, :type

#number == string, type == 'pass' or 'cargo'
  def initialize(number)
    @number = number.to_s
    @speed = 0
    @@all ||= Array.new
    @@all << self
  end

  def self.find(number)
    @@all.find { |train| train.number == number }
  end

  def add_carriage(carriage)
    if @speed.zero? && (carriage.type == self.type)
      @carriages ||= Array.new
      @carriages << carriage
    end
  end

  def delete_carriage(carriage)
    if @speed.zero?
      @carriages.delete(carriage)
      puts "Carriage #{carriage.number} was deleted from the train #{self.number}"
    else
      puts 'Firstly stop the train.'
    end
  end

  def set_current_route(route)
    @current_route = route
    @current_index = 0
    @current_station = @current_route.stations[0]
    @current_station.add_train(self)
  end

  def current_station
    @current_station  = self.current_route.stations.each { |station| return station if station.trains.include?(self) }
  end

  def next_station
    if current_index == (@current_route.stations.size - 1)
      puts 'The train is already at the end station!'
      @next_station = @current_route.stations[-1]
    else
      @next_station = self.current_route.stations[(current_index + 1)]
    end
  end

  def previous_station
    if current_index.zero?
      puts 'The train is already at the begining station!'
      @previous_station = current_route.stations[0]
    else
      @previous_station = current_route.stations[current_index - 1]
    end
  end

  def go_next_station
    @current_station.send_train(self)
    @current_station = self.next_station
    @current_station.add_train(self)
  end

  def go_previous_station
    @current_station.send_train(self)
    @current_station = self.previous_station
    @current_station.add_train(self)
  end



  private

# current_index private, 'cause used only by methods of instance.
  def current_index
    @current_index = @current_route.stations.index(@current_station)
  end
end
