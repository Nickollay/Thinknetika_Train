class PassengerTrain < Train
  def initialize(train_number)
    super
    @type = 'pass'
  end
 end