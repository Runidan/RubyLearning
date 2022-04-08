# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  attr_reader :number, :type, :speed, :wagons

  include Manufacturer
  include InstanceCounter

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
    validate!
    @speed = 0
    @wagons = []
    @@trains << self
  end

  def accelerator(value = 5)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def add_wagon(place)
    if @speed.zero?
      case @type
      when :cargo
        @wagons << CargoWagon.new(place)
      when :passenger
        @wagons << PassengerWagon.new(place)
      else
        raise RailRoadExeption, 'Отсутствуют вагоны для поезда данного типа'
      end
    end
  end

  def delete_wagon(index)
    if @speed.zero? && !@wagons.empty?
      p index
      @wagons.delete_at(index - 1)
      p @wagons
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
    end
  end

  def go_previos_station
    if @route && @current_station_index != 0
      @route.stations[@current_station_index].send_train(self)
      @current_station_index -= 1
      @route.stations[@current_station_index].add_train(self)
    end
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def valid?
    validate!
  end

  def action(&block)
    @wagons.map { |wagon| block.call(wagon) }
  end

  protected

  def validate!
    errors = []
    errors << 'Неверный тип поезда' unless @@types.include?(@type)
    errors << 'Неправильный формат номера поезда' if @number !~ /^[a-z]{3}-\d{3}$/i
    raise RailRoadExeption, errors.join("\n") unless errors.empty?

    true
  end
end
