load 'route.rb'
load 'station.rb'
load 'train.rb'

st1 = Station.new("St1")
p st1
st2 = Station.new("St2")
p st2
st3 = Station.new("St3")
p st3

route1 = Route.new(st3, st2)
p route1
route1.add_station(st1)
p route1 
=begin 
Если маршрут уже присвоен поезду и поезд находиться на конечной станции,
то при изменении машрута нужно менять current_station_index
=end
route1.show_stations
p "Удалим станцию st1 "
route1.delete_station(st1)
p "После удаления: "
route1.show_stations
p "Добавим станции в маршрут"
route1.add_station(st1)
route1.add_station(st2)
route1.add_station(st3)
route1.add_station(st1)
route1.show_stations

train1 = Train.new(4875, :cargo, 50)
p train1
train2 = Train.new(323, :passenger, 10)
p train2


train1.add_route(route1)
train2.add_route(route1)
p "Добавили маштрут поездам, посмотрим их на станции st3"
p st3.train_types
p "Текущий индекс: #{train1.current_station_index}"
train1.go_next_station
p "Текущий индекс: #{train1.current_station_index}"
p "Один поезд уехал. Должен остаться только поезд2"
p st3.train_types
p "Следующая станция поезда2: #{train2.next_station.name}"
p "Предыдущая станция поезда1: #{train1.previos_station.name}"
p "вагоны.поезда1: #{train1.vagons_count}"
train1.add_vagon
p "Вагоны после добавления: #{train1.vagons_count}"

