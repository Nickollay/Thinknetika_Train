class Station
  attr_reader :trains_on_station, :name
  def initialize(name)
    @name = name
    @trains_on_station = []
  end

  def add_train(train)
    @trains_on_station << train
  end

  def show_trains
    @trains_on_station.each {
      |train| puts "#{self.name} station: #{train.train_number}, #{train.type}"
    }
  end
  #later give to user possibility in main.rb to chose and enter variable by_type.
  def show_trains_on_station_by_type(by_type)
    @trains_on_station.select { |train| train.type == by_type}.count
  end

  def send_train(train)
    @trains_on_station.delete(train)
  end
end