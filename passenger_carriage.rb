# frozen_string_literal: true

require_relative 'carriage'
class PassengerCarriage < Carriage
  attr_reader :free_seats, :taken_seats, :seats

  def initialize(number, seats)
    super(number)
    @seats = seats
    @free_seats = @seats
    @taken_seats = @seats - @free_seats
    validate!
  end

  def type
    @type = 'pass'
  end

  def take_seat
    validate_free_seats!
    @free_seats -= 1
  end

  private

  def validate_free_seats!
    raise 'All seats taken!' if @free_seats.zero?
  end

  # If this method called from initialise of superclass, would it work?
  def validate!
    super
    raise 'Number of seats should be an Integer.' unless seats.is_a? Integer
    raise 'Number of seats should be more than 0.' unless seats.positive?
  end
end
