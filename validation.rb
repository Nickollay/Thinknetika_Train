# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanseMethods
  end

  module ClassMethods
    def validate
      # Этот метод принимает в качестве параметров имя проверяемого атрибута,
      # а также тип валидации и при необходимости дополнительные параметры.
    end
  end

  module InstanceMethods
    def valid?
      # Содержит инстанс-метод valid? который возвращает true, если все
      # проверки валидации прошли успешно и false, если есть ошибки валидации.
    end

    private
    def validate!
      # запускает все проверки (валидации),
      # указанные в классе через метод класса validate. В случае ошибки валидации выбрасывает
      # исключение с сообщением о том, какая именно валидация не прошла
    end

    def validate_presesnce
      #   - presence - требует, чтобы значение атрибута было не nil и не пустой строкой.
      # Пример использования:
      #    validate :name, :presence
    end

    def validate_format
      # - format (при этом отдельным параметром задается регулярное выражение для формата).
      # Треубет соответствия значения атрибута заданному регулярному выражению.
      # Пример:
      #     validate :number, :format, /A-Z{0,3}/
    end

    def validate_type
      # - type (третий параметр - класс атрибута). Требует соответствия значения атрибута заданному классу.
      # Пример:
      #     validate :station, :type, RailwayStation
    end
  end

  # rubocop:disable Style/AsciiComments, Layout/TrailingEmptyLines, Layout/LineLength, Lint/RedundantCopDisableDirective, Style/FrozenStringLiteralComment
  #
  # К любому атрибуту можно применить несколько разных валидаторов, например
  #
  # validate :name, :presence
  # validate :name, :format, /A-Z/
  # validate :name, :type, String
  #
  # Все указанные валидаторы должны применяться к атрибуту
  # Допустимо, что модуль не будет работать с наследниками.
  #
  #
  #     Подключить эти модули в свои классы и продемонстрировать их использование.
  # Валидации заменить на методы из модуля Validation.
  #
  #         В качестве ответа приложить ссылку на репозиторий с решением
  # rubocop:enable Style/AsciiComments,  Layout/TrailingEmptyLines, Layout/LineLength, Lint/RedundantCopDisableDirective, Style/FrozenStringLiteralComment
end
