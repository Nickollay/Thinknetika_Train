class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'pass'
  end
 end