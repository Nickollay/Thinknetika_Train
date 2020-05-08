# frozen_string_literal: true

require_relative './manufacturer'

class Carriage
  include Manufacturer

  attr_reader :type, :number

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i.freeze

  def initialize(number)
    @number = number
  end
end
