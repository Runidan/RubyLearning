# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def initialize(number)
    @type = :cargo
    @number = number
    validate!
    @speed = 0
    @wagons = []
    Train.trains << self
    register_instance
  end
end
