=begin
 - Разбить программу на отдельные классы (каждый класс в отдельном файле) 
 - Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов,
     который будет содержать общие методы и свойства
 - Определить, какие методы могут быть помещены в private/protected и вынести их в такую секцию. 
    В комментарии к методу обосновать, почему он был вынесен в private/protected
 - Вагоны теперь делятся на грузовые и пассажирские (отдельные классы). 
    К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые. 
 - При добавлении вагона к поезду, объект вагона должен передаваться как аргумент метода и сохраняться во внутреннем массиве поезда,
   в отличие от предыдущего задания, где мы считали только кол-во вагонов. 
    Параметр конструктора "кол-во вагонов" при этом можно удалить.
 
=end

class Train
  attr_reader :number, :type, :vagons_count, :speed

  def initialize(number, type, vagons_count)
    @number = number
    @type = type
    @vagons_count = vagons_count
    @speed = 0
  end

  def accelerator(value = 5)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def add_vagon
    if @speed == 0
       @vagons_count += 1
    end
  end

  def delete_vagon  
    if @speed == 0 &&  @vagons_count > 0
       @vagons_count -= 1
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
    end
  end 

  def go_previos_station
    if @route && @current_station_index != 0
      @route.stations[@current_station_index].send_train(self)
      @current_station_index -= 1
    end
  end
end

class CargoTrain < Train
  def initialize

  end
end

class PassengerTrain < Train
  def initialize

  end
end