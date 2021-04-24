# frozen_string_literal: true

require "nr2w/utils"

module Nr2w
  @output = +""
  @notation = {
    "3" => " thousand ",
    "6" => " million ",
    "9" => " billion ",
    "12" => " trillion ",
    "15" => " quadrillion ",
    "18" => " quintillion ",
    "21" => " sextillion ",
    "24" => " septillion ",
    "27" => " octillion ",
    "30" => " nonillion "
  }

  class << self
    include Utils

    def return_str
      str = @output
      @output = +""
      @negative = false
      str
    end

    # Units and dozens
    def unit_dozen_hundred(hundreds_digits)
      dozens = hundreds_digits.slice(0, 2).reverse.join.to_i
      @output.prepend dozens_str(dozens)
      return unless hundreds_digits.length > 2 && hundreds_digits[2]&.positive?

      @output.prepend hundreds_str(hundreds_digits[2], dozens.positive?)
    end

    def convert(value)
      deal_with_errors(value)
      zero_or_less(value)

      (0...@input.digits.count).step(3) do |idx|
        hundreds_digits = @input.digits.slice(idx, 3)
        number_notation(idx) if hundreds_digits.reverse.join.to_i.positive?
        unit_dozen_hundred(hundreds_digits)
      end

      @output.prepend("minus ") if @negative
      assemble_str(return_str)
    end

    def zero_or_less(value)
      @input = value
      if value.zero?
        @output = "zero"
        return
      end
      return unless value.negative?

      @negative = true
      @input = value.abs
    end

    def number_notation(value)
      @output.prepend(@notation[value.to_s] || "")
    end
  end
end
