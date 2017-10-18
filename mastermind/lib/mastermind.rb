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

  def initialize(code=nil)
    @secret_code = code || Code.random
    @turn_count = 10
    @guess = nil
  end

  def get_guess
    puts "Try to guess the secret code."
    puts "Valid colors are #{Code::PEGS.keys.join(', ').upcase}"
    guess = $stdin.gets.chomp
    Code.parse(guess)
  end

  def display_matches(code=@guess)
    puts "Your guess includes:"
    puts "#{secret_code.exact_matches(code)} exact matches."
    puts "#{secret_code.near_matches(code)} near matches."
  end

  def play
    result = nil

    until result = over?
      puts "You have #{@turn_count} guesses remaining."
      @guess = get_guess
      display_matches(@guess)
      @turn_count -= 1
    end

    puts result
  end

  def over?
    return "You won with #{@turn_count} turns left!" if @guess == secret_code
    return "You ran out of turns. The secret code is #{secret_code.pegs}." if @turn_count.zero?
    false
  end
end
