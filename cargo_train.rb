# frozen_string_literal: true

class CargoTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :length, 5
  validate :number, :format, NUMBER_FORMAT
  validate :speed, :within_the_range, (0..100)

  def initialize(number)
    super
    @type = 'cargo'
    validate!
  end

  def carriages_to_s
    each_carriage do |carriage|
      puts "Carriage number: #{carriage.number}, " \
           "type: #{carriage.type}, " \
           "free volume: #{carriage.free_volume}, " \
           "taken volume: #{carriage.taken_volume}."
    end
  end
end
