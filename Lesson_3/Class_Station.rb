=begin

Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  
=end

class Station
  attr_reader :name, :trains

  def initilaize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains.push(train)
    train.current_station(self)
  end

  def train_types
    cargo_trains = []
    passenger_trains = []
    @trains.each {|train|
      if train.type == "cargo"
        cargo_trains << train
      else
        passenger_trains << train
      end
    }
    return {"cargo trains" => cargo_trains.size, "passenger trains" =>  passenger_trains.size}
  end

  def send_train(train)
    if @trains.include?(train)
      @trains.delete(train)
      train.current_station(nil)
    end  
  end
end
