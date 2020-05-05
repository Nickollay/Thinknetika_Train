# frozen_string_literal: true

module MyAccessors
  def attr_accessor_with_history(*methods)
    options = methods.last.is_a?(Hash) ? methods.pop : {}
    @values = {}
    methods.each do |method|
      raise TypeError.new('Method name is not symbol.') unless method.is_a?(Symbol)
      values[method] = [] || [options[:default]]
      define_method(method) do
        instance_variable_get("@#{method}") ||
            instance_variable_set("@#{method}", options[:default])
      end
      define_method(method) do |value|
        @values[method] << value
        instance_variable_set("@#{method}", value)
      end
      define_method("#{method}_history") do
        instance_variable_get(@values[method])
      end
    end
  end

  def strong_attr_accessor(method, method_class)
      raise TypeError.new('Method name is not symbol.') unless method.is_a?(Symbol)
      define_method(method) do
        instance_variable_get("@#{method}")
      end

      define_method(method) do |value|
        raise TypeError.new("Method type is not #{method_class}.") unless method.is_a?(method_class)
        instance_variable_set("@#{method}", value)
      end
  end
end
#  Этот метод динамически создает геттеры и сеттеры
# для любого кол-ва атрибутов, при этом сеттер сохраняет
# все значения инстанс-переменной при изменении этого значения.

  # Также в класс, в который подключается модуль должен добавляться инстанс-метод
  #
  # <имя_атрибута>_history
  #
  #
  #
  # который возвращает массив всех значений данной переменной.
  #
  #     метод
  #
  # strong_attr_accessor
  #
  #
  #
  # который принимает имя атрибута и его класс.
  #     При этом создается геттер и сеттер для одноименной инстанс-переменной,
  #  но сеттер проверяет тип присваемоего значения.
  # Если тип отличается от того, который указан вторым параметром, то выбрасывается исключение.
  #     Если тип совпадает, то значение присваивается.

