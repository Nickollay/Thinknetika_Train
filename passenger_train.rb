# frozen_string_literal: true

class PassengerTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :length, 5
  validate :number, :format, NUMBER_FORMAT
  validate :speed, :within_the_range, (0..100)



  def initialize(number)
    super
    @type = 'pass'
    validate!
  end

  def carriages_to_s
    each_carriage do |carriage|
      puts "Carriage number: #{carriage.number}, type: #{carriage.type}, " \
           "free seats: #{carriage.free_seats}, taken seats: #{carriage.taken_seats}."
    end
  end
end
