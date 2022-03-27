require_relative 'wagon'

class PassengerWagon < Wagon

  def initialize
    @type = :passenger
    @@wagons_count += 1
    @wagon_number = @@wagons_count
  end

end  