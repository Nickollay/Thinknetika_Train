# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :name

  NAME_FORMAT = /^[A-Z][a-z]+$/.freeze

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

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

  def each_train
    @trains.map { |train| yield(train) }
  end

  def to_s
    each_train do |train|
      puts "Number: #{train.number}, " \
           "type: #{train.type}, " \
           "carriages: #{train.number_of_carriages}."
    end
  end

  def show_trains_on_station_by_type(by_type)
    @trains.select { |train| train.type == by_type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end
