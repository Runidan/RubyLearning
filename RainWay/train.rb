require_relative 'manufacturer'

class Train

  attr_reader :number, :type, :speed, :train_wagons

  include Manufacturer

  @@trains = []

  def self.find(number)
    @@trains.each do |train|
      if train.number == number
        return train
      end
    end
    return nil
  end

  def self.trains
    @@trains
  end
  
  def initialize(number, type)
    @type = type
    @number = number
    @speed = 0
    @train_wagons = []
    @@trains << self
  end

  def accelerator(value = 5)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    if @speed == 0 && wagon.type == self.type
       @train_wagons << wagon
    end
  end

  def delete_wagon
    if @speed == 0 &&  @train_wagons.size != 0
       @train_wagons.pop
    end  
  end

  def add_route(route)
    @route = route
    @route.stations[0].add_train(self)
    @current_station_index = 0
  end

  def next_station
    return @route.stations[@current_station_index + 1] if @route && @current_station_index != @route.stations.size - 1
    
  end

  def previos_station
    return @route.stations[@current_station_index - 1] if @route && @current_station_index != 0
  end  

  def go_next_station
    if @route && @current_station_index != @route.stations.size - 1
      @route.stations[@current_station_index].send_train(self)
      @current_station_index += 1
      @route.stations[@current_station_index].add_train(self)
      puts "Поезд прибыл на станцию #{@route.stations[@current_station_index].name}"
    end
  end 

  def go_previos_station
    if @route && @current_station_index != 0
      @route.stations[@current_station_index].send_train(self)
      @current_station_index -= 1
      @route.stations[@current_station_index].add_train(self)
      puts "Поезд прибыл на станцию #{@route.stations[@current_station_index].name}"
    end
  end
end

class CargoTrain < Train
  def initialize(number)
    @type = :cargo
    @number = number
    @speed = 0
    @train_wagons = []
  end
end

class PassengerTrain < Train
  def initialize(number)
    @type = :passenger
    @number = number
    @speed = 0
    @train_wagons = []
  end
end