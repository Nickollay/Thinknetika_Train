# frozen_string_literal: true

class Station
  include InstanceCounter
  attr_reader :trains, :name

  NAME_FORMAT = /^[A-Z][a-z]+$/.freeze

  def initialize(name)
    register_instance
    @name = name
    validate!
    @@all ||= []
    @@all << self
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def self.all
    @@all
  end

  def add_train(train)
    @trains ||= []
    @trains << train
  end

  # def to_s
  #   @trains.each {
  #     |train| puts "#{self.name} station: #{train.number}, #{train.type}"
  #   }
  # end

  def each_train
    @trains.map { |train| yield(train) }
  end

  def to_s
    train = proc { |train| "Number: #{train.number}, type: #{train.type}, carriages: #{train.number_of_carriages}." }
    each_train(&train)
  end

  def show_trains_on_station_by_type(by_type)
    @trains.select { |train| train.type == by_type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  private

  def validate!
    if name !~ NAME_FORMAT
      raise 'Format of name should be: start with capital letter than downcase letters.'
    end
    raise 'Length of name should be more than 3 characters.' if name.length < 4
  end
end
