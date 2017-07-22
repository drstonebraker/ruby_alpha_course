class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_move
    puts 'Please type the location of where you want to move.'
    puts "Format should be e.g. '0, 0' for top left corner."
    gets.chomp.split(/\,\s*/).map(&:to_i)
  end
end
