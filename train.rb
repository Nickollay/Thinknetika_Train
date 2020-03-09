class Train
  attr_accessor :speed
  attr_reader :number_of_carriages, :previous_station, :current_station, :next_station

#train_number == string, type == 'pass' or 'cargo'
  def initialize(train_number, type, number_of_carriages)
    @train_number = train_number.to_s
    @type = type
    @number_of_carriages = number_of_carriages
    @speed = 0
    @current_route = []
    @next_station = nil
    @current_station = nil
    @previous_station = nil
  end

  def add_carriage
    @number_of_carriages += 1 if @speed == 0
  end

  def delete_carriage
    @number_of_carriages -=1 if @speed == 0
  end

  def set_current_route(route)
    @current_route = route

    #why it does't work without .route? How to make it to work without, if possible?
    @current_station = @current_route[0]
    @current_station.add_train(self)
  end

#later refactor for situations when @carrent_station == last station in @current_route
  def go_next_station
    @next_station = @current_route[@current_route.index(@current_station) + 1]
    @current_station.send_train(self)
    @current_station = @next_station
    @current_station.add_train(self)
  end

#later refactor for situations when @carrent_station == first station in @current_route
  def go_previous_station
    @previous_station = @current_route[@current_route.index(@current_station) - 1]
    @current_station.send_train(self)
    @current_station = @previous_station
    @current_station.add_train(self)
  end
end