require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'wagons'
require_relative 'menu'


def seed(menu)
  st1 = Station.new(:Златоуст)
  menu.stations[st1.name] = st1
  st2 = Station.new(:Аша)
  menu.stations[st2.name] = st2
  st3 = Station.new(:Уфа)
  menu.stations[st3.name] = st3
  st4 = Station.new(:Самара)
  menu.stations[st4.name] = st4
  st5 = Station.new(:Нижний)
  menu.stations[st5.name] = st5
  st6 = Station.new(:Рязань)
  menu.stations[st6.name] = st6
  st7 = Station.new(:Москва)
  menu.stations[st7.name] = st7

  rt1 = Route.new(st1, st7)
  rt2 = Route.new(st6, st1)
  rt1.add_station(st2)
  rt1.add_station(st3)
  rt1.add_station(st4)
  rt1.add_station(st5)
  rt1.add_station(st6)
  rt2.add_station(st5)
  menu.routes << rt1
  menu.routes << rt2

  tr1 = Train.new(13, :cargo, 15)
  tr1.add_route(rt1)
  menu.trains << tr1
  tr2 = Train.new(181, :passenger, 12)
  tr2.add_route(rt2)
  menu.trains << tr2

end

menu1 = Menu.new
seed(menu1)

menu1.main_menu