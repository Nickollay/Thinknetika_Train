# frozen_string_literal: true

require_relative './manufacturer'

class Carriage
  include Manufacturer
  attr_reader :type, :number

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i.freeze

  def initialize(number)
    @number = number
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
    return unless number !~ NUMBER_FORMAT

    raise 'Format: 3 digits/characters optional '-' and 2numbers/characters.'
  end
end
