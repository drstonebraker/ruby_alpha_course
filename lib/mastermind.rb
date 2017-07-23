class Code
  attr_reader :pegs
  PEGS = {
    r: :red,
    g: :green,
    b: :blue,
    y: :yellow,
    o: :orange,
    p: :purple
  }

  def self.parse(str)
    code = str.downcase.chars
    code.each do |peg|
      raise "#{peg.upcase} is not a valid color" unless PEGS.keys.include?(peg.to_sym)
    end
    self.new(str.downcase.chars)
  end

  def self.random
    colors = PEGS.keys
    self.new(Array.new(4) {colors[rand(0..colors.length.pred)].to_s})
  end

  def initialize(pegs)
    @pegs = pegs
  end

  def [](idx)
    @pegs[idx]
  end

  def exact_matches(comparison)
    counter = 0
    (0..3).each do |i|
      counter += 1 if comparison[i] == pegs[i]
    end
    counter
  end

  def near_matches(comparison)
    comparison_pegs = comparison.pegs.dup
    counter = 0
    pegs.each do |peg|
      match_idx = comparison_pegs.index(peg)
      if match_idx
        counter += 1
        comparison_pegs.delete_at(match_idx)
      end
    end
    counter - exact_matches(comparison)
  end

  def ==(comparison)
    return false unless comparison.is_a?(Code)
    exact_matches(comparison) == 4
  end
end

class Game
  attr_reader :secret_code
end
