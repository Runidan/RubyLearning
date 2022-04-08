# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @stations = []

  class << self
    attr_accessor :stations

    def all
      @stations
    end
  end

  

  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.class.stations << self
    register_instance
  end

  def add_train(train)
    @trains.push(train)
  end

  def send_train(train)
    @trains.delete(train) if @trains.include?(train)
  end

  def valid?
    validate!
  end

  def action(&block)
    @trains.map { |train| block.call(train) }
  end

  protected

  def validate!
    errors = []
    errors << 'Неверный формат названия станции' if @name !~ /^[А-ЯЁA-Z][а-яёa-z]*$/
    errors << 'Название станции не может быть пустым' if @name.nil?
    errors << 'Название станции должно быть больше друх символов' if @name.size < 3
    raise RailRoadExeption, errors.join("\n") unless errors.empty?

    true
  end
end
