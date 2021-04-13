# frozen_string_literal: true

require "nr2w/utils"

module Nr2w
  @str = +""

  class << self
    include Utils

    def return_str
      str = @str
      @str = +""
      str
    end

    # Units and dozens
    def unit_dozen_hundred(hundreds_digits)
      dozens = hundreds_digits.slice(0, 2).reverse.join.to_i
      @str.prepend dozens_str(dozens)
      return unless hundreds_digits.length > 2 && hundreds_digits[2]&.positive?

      @str.prepend hundreds_str(hundreds_digits[2], dozens.positive?)
    end

    def convert(value)
      deal_with_errors(value)

      # Transform into positive and set negative as true
      @negative =
        if value.negative?
          value = value.abs
          true
        end

      (0...value.digits.count).step(3) do |idx|
        hundreds_digits = value.digits.slice(idx, 3)
        number_notation(idx) if hundreds_digits.reverse.join.to_i.positive?
        unit_dozen_hundred(hundreds_digits)
      end

      @str.prepend("minus ") if @negative
      @str = "zero" if value.zero?

      assemble_str(return_str)
    end

    def number_notation(index)
      name =
        case index
        when 3
          " thousand "
        when 6
          " million "
        when 9
          " billion "
        when 12
          " trillion "
        when 15
          " quadrillion "
        when 18
          " quintillion "
        when 21
          " sextillion "
        when 24
          " septillion "
        when 27
          " octillion "
        when 30
          " nonillion "
        else
          ""
        end
      @str.prepend name
    end
  end
end
