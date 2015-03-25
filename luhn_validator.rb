module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def my_inject(a, b)
    a.each_index.inject(0) { |sum, index|
      if index % 2 == 0
        sum + a[index]
      elsif b * a[index] >= 10
        sum + my_inject(((b * a[index]).to_s.chars.map(&:to_i)), 1)
      else
        sum + (b * a[index])
      end
    }
  end
  
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    nums_a.reverse!
    checksum = my_inject(nums_a, 2)
    checksum % 10 == 0
  end
end
