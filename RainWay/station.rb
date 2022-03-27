require_relative 'instanceCounter'

class Station

  include InstanceCounter

  attr_reader :name, :trains
  @@stations = []

  def self.all
      @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    self.register_instance
  end

  def add_train(train)
    @trains.push(train)
  end

  def train_types
    cargo_trains = 0
    passenger_trains = 0
    @trains.each do |train|
      if train.type == :cargo
        cargo_trains += 1
      else
        passenger_trains += 1
      end
    end
    return {:cargo => cargo_trains, :passenger =>  passenger_trains}
  end

  def send_train(train)
    if @trains.include?(train)
      @trains.delete(train)
    end  
  end
end
