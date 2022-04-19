# frozen_string_literal: true
require_relative '../validation'
require_relative '../manufacturer'
require_relative '../instance_counter'

class Train

  extend Validation
  include Manufacturer
  include InstanceCounter
  
  attr_reader :number, :type, :speed, :wagons

  validate

  @@trains = []
  @@types = %i[cargo passenger]

  class << self
    def find(number)
      @@trains.each do |train|
        return train if train.number == number
      end
      nil
    end

    def trains
      @@trains
    end

    def trains_set(train)
      @@trains << train
    end
  end

  def initialize(number, type)
    @type = type
    @number = number
    validate!(:number, :presence)
    validate!(:type, :presence)
    rdx = Regexp.new("/^[a-z]{3}-\d{3}$/i")
    validate!(:number, :format, rdx)
    @speed = 0
    @wagons = []
    @@trains << self
    register_instance
  end

  def accelerator(value = 5)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def add_wagon(place)
    return unless @speed.zero?

    case @type
    when :cargo
      @wagons << CargoWagon.new(place)
    when :passenger
      @wagons << PassengerWagon.new(place)
    else
      raise RailRoadExeption, 'Отсутствуют вагоны для поезда данного типа'
    end
  end

  def delete_wagon(index)
    return unless @speed.zero? && !@wagons.empty?

    @wagons.delete_at(index - 1)
  end

  def add_route(route)
    @route = route
    @route.stations[0].add_train(self)
    @current_station_index = 0
  end

  def next_station
    return raise RailRoadExeption, 'Поезду не присвоен маршрут' if @route.nil?
    return @route.stations[@current_station_index + 1] if @route && @current_station_index != @route.stations.size - 1
  end

  def previos_station
    return raise RailRoadExeption, 'Поезду не присвоен маршрут' if @route.nil?
    return @route.stations[@current_station_index - 1] if @route && @current_station_index != 0
  end

  def go_next_station
    return raise RailRoadExeption, 'Поезду не присвоен маршрут' if @route.nil?
    return unless @route && @current_station_index != @route.stations.size - 1

    @route.stations[@current_station_index].send_train(self)
    @current_station_index += 1
    @route.stations[@current_station_index].add_train(self)
  end

  def go_previos_station
    return raise RailRoadExeption, 'Поезду не присвоен маршрут' if @route.nil?
    return unless @route && @current_station_index != 0

    @route.stations[@current_station_index].send_train(self)
    @current_station_index -= 1
    @route.stations[@current_station_index].add_train(self)
  end

  def current_station
    return raise RailRoadExeption, 'Поезду не присвоен маршрут' if @route.nil?

    @route.stations[@current_station_index]
  end

  def action(&block)
    @wagons.map { |wagon| block.call(wagon) }
  end
end
