class CargoTrain < Train
  def initialize(number)
    super
    @type = 'cargo'
  end

  def carriages_to_s
    carriage = proc do |carriage|
      "Carriage number: #{carriage.number}, type: #{carriage.type}, free volume: #{carriage.free_volume}, taken volume: #{carriage.taken_volume}."
    end
    each_carriage(&carriage)
  end
end