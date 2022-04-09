# frozen_string_literal: true

require_relative 'route_actions'
require_relative 'station_actions'
require_relative 'train_actions'
require_relative 'wagon_actions'

class Menu
  attr_reader :routes

  include RoutesActions
  include StationActions
  include TrainActions
  include WagonActions

  def initialize
    @routes = []
  end

  def main_menu
    choice0 = 1
    m_main = { 1 => :menu_stations, 2 => :make_train, 3 => :menu_train, 4 => :menu_route }
    until choice0.zero?
      show_mainmenu
      choice0 = gets.chomp.to_i
      m_main.key?(choice0) ? method(m_main[choice0]).call : choice0 = 0
    end
  end

  private

  def show_mainmenu
    main_menu = <<-MENU
    Выберете действие:
    1 - Действия со станциями
    2 - Создать поезд
    3 - Действия с поездами и вагонами
    4 - Действия с маршрутами
    0 - Выйти из программы
    MENU
    puts main_menu
  end
end
