# frozen_string_literal: true

class CargoTrain < Train
  def initialize(number)
    super
    @type = 'cargo'
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
