# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'accessors'

class Station
  extend Validation
  include InstanceCounter

  attr_reader :name, :trains

  validate

  @stations = []

  class << self
    attr_accessor :stations

    def all
      @stations
    end
  end

  def initialize(name)
    @name = name
    validate!(:name, :presence)
    rdx = Regexp.new("/^[А-ЯЁA-Z][а-яёa-z]*$/")
    validate!(:name, :format, rdx)
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

  def action(&block)
    @trains.map { |train| block.call(train) }
  end

end
