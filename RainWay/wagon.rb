class Wagon
  @@wagons_count = 0

  attr_reader :type, :wagon_number

  def initialize(type)
    @type = type
    @@wagons_count += 1
    @wagon_number = @@wagons_count
  end
end


