# frozen_string_literal: true

class CargoCarriage < Carriage
  attr_reader :free_volume, :taken_volume

  def initialize(number, volume)
    super(number)
    @volume = volume
    @free_volume = @volume
    @taken_volume = @volume - @free_volume
    validate!
  end

  def type
    @type = 'cargo'
  end

  def take_volume(cargo)
    validate_free_volume!(cargo)
    @free_volume -= cargo
  end

  private

  def validate_free_volume!(cargo)
    raise 'No free volume anymore!' if @free_volume.zero?
    raise 'There are not enough volume!' if cargo > @free_volume
  end

  def validate!
    super
    raise 'Volume should be more than 0.' unless @volume.positive?
  end
end
