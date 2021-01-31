module Utils
  def unit_digit(value)
    array = ['', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight',
             'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen',
             'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen']
    array[value]
  end

  def dozen_digit(value)
    array = ['', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy',
             'eigthy', 'ninety']
    array[value]
  end

  def dozens_str(value)
    # This validation is necessary because of the special name cases between 11 and 19, or else it would be value < 10
    if value < 20 # EX: onze, doze, treze etc
      unit_digit(value)
    else
      digits = value.digits.reverse
      append = " #{unit_digit(digits[1])}" if unit_digit(digits[1]) != '' # EX: vinte OU vinte um
      "#{dozen_digit(digits[0])}#{append}"
    end
  end

  def hundreds_str(value, surplus = false)
    append = surplus == false ? ' hundred' : ' hundred and '
    unit_digit(value) + append
  end

  def assemble_str(str)
    array = str.split(' ')
    final_arr = []
    array.each_with_index do |item, index|
      final_arr << " #{item}"
      if %w[nonillion octillion septill ion sextillion quintillion quadrillion trillion billion million thousand].include?(item) && index != array.size - 1
        final_arr << ','
      end
    end
    final_arr.reject(&:empty?).join('').strip
  end
end
