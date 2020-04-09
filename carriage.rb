# frozen_string_literal: true

require_relative './manufacturer'

class Carriage
  include Manufacturer
  attr_reader :type, :number

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i.freeze

  def initialize(number)
    @number = number
    # validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise 'Number is too short!' if number.length < 5
    if number !~ NUMBER_FORMAT
      raise 'Number format: three digits or characters optional dash and two more numbers or characters.'
    end
  end
end
