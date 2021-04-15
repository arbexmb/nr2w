# frozen_string_literal: true

module Nr2w
  module Utils
    UNIT_DIGITS = [
      "",
      "one", "two", "three", "four", "five", "six", "seven", "eight",
      "nine", "ten", "eleven", "twelve", "thirteen", "fourteen",
      "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
    ].freeze
    private_constant :UNIT_DIGITS

    DOZEN_DIGITS = [
      "", "",
      "twenty", "thirty", "forty", "fifty",
      "sixty", "seventy", "eigthy", "ninety"
    ].freeze
    private_constant :DOZEN_DIGITS

    THOUSAND_DIGITS = %w[
      nonillion octillion septill ion sextillion
      quintillion quadrillion trillion billion million thousand
    ].freeze
    private_constant :THOUSAND_DIGITS

    def dozens_str(value)
      if value < 20
        UNIT_DIGITS[value]
      else
        digits = value.digits.reverse
        if digits[1].positive?
          "#{DOZEN_DIGITS[digits[0]]} #{UNIT_DIGITS[digits[1]]}"
        else
          DOZEN_DIGITS[digits[0]]
        end
      end
    end

    def hundreds_str(value, surplus = false)
      append = surplus ? " hundred and " : " hundred"
      UNIT_DIGITS[value] + append
    end

    def assemble_str(str)
      array = str.split(" ")
      final_arr = +""
      array.each_with_index do |item, index|
        final_arr << " #{item}"
        final_arr << "," if THOUSAND_DIGITS.include?(item) && index != array.size - 1
      end
      final_arr.sub(" ", "")
    end

    def deal_with_errors(value)
      raise "Not an integer" unless value.is_a? Integer
      raise "Overflow" unless value.abs < 2**100
    end
  end
end
