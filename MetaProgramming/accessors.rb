# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*args)
    args.each do |arg|
      raise TypeError, 'аргумент не является символом' unless arg.is_a?(Symbol)

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

  def strong_attr_accessor(name, arg_class)
    raise TypeError, "#{name}  is not symbol" unless name.is_a?(Symbol)
    raise TypeError, "#{arg_class} is not class" unless arg_class.instance_of?(Class)

    define_method(name) do
      instance_variable_get("@#{name}")
    end
    define_method("#{name}=") do |arg|
      unless arg.instance_of?(arg_class)
        raise TypeError, "Неверный класс аргумента. Ожидается переменная класса #{arg_class}"
      end

      instance_variable_set("@#{name}", arg)
    end
  end
end
