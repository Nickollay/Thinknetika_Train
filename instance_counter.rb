module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    # Методы класса:
    #  - instances, который возвращает кол-во экземпляров данного класса
    #
    def instances
      self.instances ||= 0
    end

    # def initialize
    #
    #   @instances += 1
    # end

    #private
  end

  module InstanceMethods
    # Инастанс-методы:
    #     - register_instance, который увеличивает счетчик кол-ва экземпляров класса
    # и который можно вызвать из конструктора.
    #     При этом данный метод не должен быть публичным.
    # Подключить этот модуль в классы поезда, маршрута и станции.
    #
      # Примечание: инстансы подклассов могут считатья по отдельности,
      # не увеличивая счетчик инстансев базового класса.
    #

  end


end