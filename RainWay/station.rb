require_relative 'instanceCounter'

class Station

  include InstanceCounter

  attr_reader :name, :trains
  @@stations = []

  def self.all
      @@stations
  end

  
  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    self.register_instance
  end

  def add_train(train)
    @trains.push(train)
  end

  def send_train(train)
    if @trains.include?(train)
      @trains.delete(train)
    end  
  end

  def valid?
    validate!
  end

  def action(&block)
    @trains.map {|train| block.call(train)}
  end

  protected
  def validate!
    errors = []
    errors << "Неверный формат названия станции" if @name !~ /^[А-ЯЁA-Z][а-яёa-z]*$/
    errors << "Название станции не может быть пустым" if @name.nil?
    errors << "Название станции должно быть больше друх символов" if @name.size < 3
    raise RailRoadExeption.new(errors.join("\n")) unless errors.empty?
    true
  end
end
