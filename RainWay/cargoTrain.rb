require_relative 'train'

class CargoTrain < Train
  def initialize(number)
    @type = :cargo
    @number = number
    validate!
    @speed = 0
    @train_wagons = []
    Train.trains << self
    self.register_instance
  end
end