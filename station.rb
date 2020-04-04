require_relative './instance_counter'
class Station
  include InstanceCounter
  attr_reader :trains, :name

  NAME_FORMAT = /^[A-Z][a-z]+$/

  def initialize(name)
    register_instance
    @name = name
    validate!
    @@all ||= Array.new
    @@all << self
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def self.all
    @@all
  end

  def add_train(train)
    @trains ||= Array.new
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

  private

  def validate!
    raise 'Format of name should be: start with capital letter than downcase letters.' if name !~ NAME_FORMAT
    raise 'Length of name should be more than 3 characters.' if name.length < 4
  end
end