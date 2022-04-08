# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    @type = :passenger
    @number = number
    validate!
    @speed = 0
    @wagons = []
    Train.trains << self
    register_instance
  end
end
