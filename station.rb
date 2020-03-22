class Station
  attr_reader :trains, :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def to_s
    @trains.each {
      |train| puts "#{self.name} station: #{train.number}, #{train.type}"
    }
  end

  def show_trains_on_station_by_type(by_type)
    @trains.select { |train| train.type == by_type}
  end

  def send_train(train)
    @trains.delete(train)
  end
end