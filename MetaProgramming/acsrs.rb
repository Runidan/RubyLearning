module Accessors

  def attr_accessor_with_history(*args)
    args.each do |arg|
      raise TypeError.new("аргумент не является символом") unless arg.is_a?(Symbol)
      define_method(arg) do
        instance_variable_get("@#{arg}")
      end
      define_method("#{arg}_history") do
        instance_variable_get("@#{arg}_history")
      end
      define_method("#{arg}=") do |v|
        args_tmp = instance_variable_get("@#{arg}_history") || instance_variable_set("@#{arg}_history", [])
        args_tmp << v
        instance_variable_set("@#{arg}_history", args_tmp)
        instance_variable_set("@#{arg}", v)
      end
    end
  end

end
