# frozen_string_literal: true

require_relative 'carriage'
class PassengerCarriage < Carriage
  attr_reader :free_seats, :taken_seats, :seats

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :seats, :type, Integer
  validate :seats, :positive


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
end
