=begin
  
+/-Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
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
  attr_reader :number, :speed, :how_many_vagons, :next_station, :previos_station
  attr_accessor :current_station


  def initilaize(numder, type, how_many_vagons)
    @number = number
    @type = ""
    @how_many_vagons = how_many_vagons
    @speed = 0
    @route = nil
    @current_station = nil
    @next_station = nil
    @previos_station = nil
  end

  def accelerator
    @speed += 5
  end

  def stop
    @speed = 0
  end

  def add_vagon
    if @speed == 0
      @how_many_vagons += 1
    end

  def delete_vagon  
    if @speed == 0 && @how_many_vagons > 0
      @how_many_vagons -= 1
    end  
  end

  def add_route(route)
    @route = route
    route.first_station.add_train(self)
    self.what_next_station
  end

  def what_next_station
    if @route && @current_station != @route.last_station
      all_route = self.route.list_stations.unshift(self.route.first_station) << self.route.last_station
      @next_station = all_route[all_route.index(@current_station) + 1]
    else
      @next_station = nil
    end
  end

  def what_previos_station
    if @route && @current_station != @route.first_station
      all_route = self.route.list_stations.unshift(self.route.first_station) << self.route.last_station
      @previos_station = all_route[all_route.index(@current_station) - 1]
    else
      @previos_station = nil
    end
  end  

  def go_next_station
    @current_station.send_train(self)
    @current_station = @next_station
    self.what_next_station
  end 

  def go_previos_station
    @current_station.send_train(self)
    @current_station = @previos_station
    self.what_previos_station
  end
end