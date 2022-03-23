=begin

Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  
=end

class Station
   attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
