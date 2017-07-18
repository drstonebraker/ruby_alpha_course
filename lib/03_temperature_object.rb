class Temperature

  def initialize(hash)
    key = hash.keys[0]
    if [:fahrenheit, :f].include? key
      @temp = Fahrenheit.new(hash[key])
    elsif [:celsius, :c].include? key
      @temp = Celsius.new(hash[key])
    else
      raise "Invalid temperature type. Use :fahrenheit, :celsius, :f, or :c"
    end
  end

  def in_celsius
    if @temp.is_a? Celsius
      @temp.value
    else
      ftoc(@temp.value)
    end
  end

  def in_fahrenheit
    if @temp.is_a? Fahrenheit
      @temp.value
    else
      ctof(@temp.value)
    end
  end

  def self.from_fahrenheit(value)
    Fahrenheit.new(value)
  end

  def self.from_celsius(value)
    Celsius.new(value)
  end

  private

  def ftoc(f)
    ((f + 40) * 5.0 / 9) - 40
  end

  def ctof(c)
    ((c + 40) * 9.0 / 5) - 40
  end

end

class Fahrenheit < Temperature
  attr_reader :value

  def initialize(value)
    @value = value
    @temp = self
  end
end

class Celsius < Temperature
  attr_reader :value

  def initialize(value)
    @value = value
    @temp = self
  end
end
