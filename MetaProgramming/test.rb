require_relative 'acsrs'

class MyClass
  extend Accessors

  attr_accessor_with_history :ac1, :ac2, :ac3

  def initialize
  end
end