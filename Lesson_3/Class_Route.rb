=begin

Имеет начальную и конечную станцию, а также список промежуточных станций.
Начальная и конечная станции указываются при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной

=end

class Route
  def initilaize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list_stations = []
  end

  def add_station(station)
    @list_stations << station
  end

  def delete_station(station)
    @list_stations.delete(station)
  end

  def show_list_station
    puts @first_station.name
    @list_stations.each {|station| puts station.name}
    puts @last_station.name
  end
end