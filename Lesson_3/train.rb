=begin
  
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов
Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
    Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route). 
    При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
 
=end

class Train
  attr_reader :number, :type, :vagons_count, :speed


  def initilaize(numder, type, vagons_count)
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

  def delete_vagon  
    if @speed == 0 &&  @vagons_count > 0
       @vagons_count -= 1
    end  
  end

  def add_route(route)
    @route = route
    route.stations(0).add_train(self)
    @current_station_index = 0
  end

  def what_next_station
    return @route.stations(@current_station_index + 1) if @route && @current_station_index != @route.stations.size - 1
  end

  def what_previos_station
    return @route.station(@current_station_index - 1) if @route && @current_station_index != 0
  end  

  def go_next_station
    if @route && @current_station_index != @route.stations.size - 1
      @current_station.send_train(self)
      @current_station += 1
    end
  end 

  def go_previos_station
    if @route && @current_station_index != 0
      @current_station.send_train(self)
      @current_station_index -= 1
    end
  end
end
