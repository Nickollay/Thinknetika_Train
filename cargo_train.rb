class CargoTrain < Train
  def initialize(train_number, number_of_carriages)
    super
    @type = 'cargo'
  end
end