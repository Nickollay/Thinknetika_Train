class PassengerTrain < Train
  def initialize(train_number, number_of_carriages)
    super
    @type = 'pass'
  end
 end