require 'pry'
class Y
  p Y
  define_method(:my_method) do
    p self
    puts "methots body"
  end

  class << self
    def clas_meth
      p Y
      p 'clas_meth'
    end
  end
end

a = 7

puts a