class Carriage
  attr_reader :carriage_type, :carriage_number

  def initialize(carriage_number)
    @carriage_number = carriage_number
  end
end