# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'pass'
  end

  def carriages_to_s
    each_carriage do |carriage|
      puts "Carriage number: #{carriage.number}, type: #{carriage.type}, " \
           "free seats: #{carriage.free_seats}, taken seats: #{carriage.taken_seats}."
    end
  end
end
