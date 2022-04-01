require_relative 'manufacturer'
require_relative 'instanceCounter'

class Train

  attr_reader :number, :type, :speed, :train_wagons

  include Manufacturer
  include InstanceCounter

  @@trains = []
  @@types = [:cargo, :passenger]

  class << self
    def find(number)
      @@trains.each do |train|
        if train.number == number
          return train
        end
      end
      return nil
    end
  
    def trains
      @@trains
    end

    def trains_set(train)
      @@trains << train
    end

  end
  
    
  def initialize(number, type)
    #redex = /([a-z]{3}-\d{3})/i
    @type = type
    @number = number
    validate!
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

  def add_wagon
    if @speed == 0
      if @type == :cargo
        @train_wagons << CargoWagon.new
      elsif @type == :passenger
        @train_wagons << PassengerWagon.new
      else
        raise RailRoadExeption.new("Отсутствуют вагоны для поезда данного типа")
      end
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

  def valid?
    validate!
  end

  protected
  def validate!
    raise RailRoadExeption.new("Неверный тип поезда") if !@@types.include?(@type)
    raise RailRoadExeption.new("Неправильный формат номера поезда") if @number !~ /^[a-z]{3}-\d{3}$/i
    true
  end
end

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

class PassengerTrain < Train
  def initialize(number)
    @type = :passenger
    @number = number
    validate!
    @speed = 0
    @train_wagons = []
    Train.trains << self
    self.register_instance
  end
end