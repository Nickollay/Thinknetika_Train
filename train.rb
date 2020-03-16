class Train
  attr_accessor :speed
  attr_reader :carriages, :current_route, :train_number, :type

#train_number == string, type == 'pass' or 'cargo'
  def initialize(train_number)
    @train_number = train_number.to_s
    @type = "type don't defined yet"
    @carriages = []
    @speed = 0
    @current_route = []
  end

  def add_carriage(carriage)
    if @speed.zero? && (carriage.carriage_type == self.type)
      @carriages << carriage
      puts "Carriage #{carriage} added."
    else
      puts 'Wrong type of carriage.'
    end
  end

  def delete_carriage(carriage)
    @carriages.delete(carriage) if @speed.zero?
    puts "Carriage #{carriage} deleted."
  end

#protected??
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
#current_index used only by methods of instance.
  def current_index
    @current_index = @current_route.stations.index(@current_station)
  end
end
