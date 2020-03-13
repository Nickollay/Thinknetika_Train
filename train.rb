class Train
  attr_accessor :speed
  attr_reader :number_of_carriages, :current_route, :train_number, :type

#train_number == string, type == 'pass' or 'cargo'
  def initialize(train_number, type, number_of_carriages)
    @train_number = train_number.to_s
    @type = type
    @number_of_carriages = number_of_carriages
    @speed = 0
    @current_route = []
  end

  def add_carriage
    @number_of_carriages += 1 if @speed.zero?
  end

  def delete_carriage
    @number_of_carriages -=1 if @speed.zero?
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

  def current_index
    @current_index = @current_route.stations.index(@current_station)
  end

  def next_station
    if self.current_index == (@current_route.stations.size - 1)
      puts 'The train is already at the end station!'
      @next_station = @current_route.stations[-1]
    else
      @next_station = self.current_route.stations[(self.current_index + 1)]
    end
  end

  def previous_station
    if self.current_index.zero?
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
end
