class Train
  attr_accessor :speed
  attr_reader :number_of_carriages


#train_number == string, type == 'pass' or 'cargo'
  def initialize(train_number, type, number_of_carriages)
    @train_number = train_number
    @type = type
    @number_of_carriages = number_of_carriages
    @speed = 0
    @current_route = []
  end

  def add_carriage
    @number_of_carriages += 1 if @speed == 0
  end

  def delete_carriage
    @number_of_carriages -=1 if @speed == 0
  end




end