require_relative 'wagon'

class CargoWagon < Wagon

  def initialize
    @type = :cargo
    @@wagons_count += 1
    @wagon_number = @@wagons_count
  end

end 