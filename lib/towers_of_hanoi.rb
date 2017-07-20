# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp.html) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi
  attr_reader :towers
  @@wrong_move_msg = [
    "You can't put that there!  Try again.",
    "It's not fitting there.  Try again.",
    'That move is no good.  Try again.'
  ]
  @@platform_index = {
    'a' => 0,
    'b' => 1,
    'c' => 2
  }

  def initialize
    @towers = [[3,2,1],[],[]]
    @moves_counter = 0
  end

  def play
    puts ''
    puts '**TOWERS OF HANOI**'
    puts 'Type "help" at any time for instructions or "quit" to forfeit the challenge'

    return false unless (difficulty = get_difficulty)

    render

    until won?
      return false unless (move_from = get_from_move)
      return false unless (move_to = get_to_move(move_from))
      move(move_from, move_to)
      @moves_counter += 1
      render
    end

    puts "Congratulations!  You successfully completed the challenge, Towers of Hanoi,"\
        " in only #{@moves_counter} moves!"

    if @moves_counter == 6 * (2**(difficulty - 1)) + 2**difficulty - 1 #formula for determining fewest possible moves
      puts "That's the fewest possible moves (not counting invalid ones) to beat this difficulty level!"
    else
      puts "Try again to see if you can do it in even fewer moves!"
    end
    return true
  end

  # private

  def get_difficulty
    loop do
      puts ''
      puts 'Choose a difficulty level (1-5)' # determines height of tower
      difficulty = gets.chomp.downcase

      case difficulty
      when ('1'..'5')
        setup_towers(difficulty.to_i)
        return difficulty.to_i
      else
        return false unless execute_command(difficulty)
      end

    end
  end

  def setup_towers(difficulty)
    difficulty += 2
    @towers = [(difficulty.downto(1)).to_a, [], []]
  end

  def execute_command(cmd)
    case cmd
    when 'help'
      help
    when 'quit', 'exit'
      return false
    else
      puts 'That is not a valid input. Please try again.'
    end
    true
  end

  def help # for when player types 'help'
    puts "-The object of the game is to move the entire tower from platform A to platform C."
    puts "-The tower is made up of multiple segments of different sizes,"\
    " ranging from smallest at the top to largest at the base."
    puts "-You must move the entire tower only one segment at a time."
    puts "-Each turn, you must remove the topmost tower segment"\
    " from one platform and place it on another platform."
    puts "-You may choose either of the other two platoforms to place the new segment,"\
    " but it will always go on top of any other segments that already exist at that platform."
    puts "-There is, however, one more rule:"
    puts "-A segment may never be placed on top of another segment that is smaller than it."\
    " Segments must be moved either to empty platforms or on top or larger segments."
    puts ""
    puts "-Once you have moved the entire tower to platform C, you have won the challenge!"
    puts ""
  end

  def render
    i = @towers.map(&:count).max

    puts ''

    while i >= 0 #iterate through each printed row (highest to lowest) to create towers
      #set this row's segment value for each platform
      a_segment = @towers[0][i] == nil ? ' ' : @towers[0][i]
      b_segment = @towers[1][i] == nil ? ' ' : @towers[1][i]
      c_segment = @towers[2][i] == nil ? ' ' : @towers[2][i]
      #print the segments in each tower at this given index/row
      puts "  #{a_segment}      #{b_segment}      #{c_segment}"
      i -= 1
    end

    puts "-----  -----  -----"
    puts "  A      B      C"
    puts ""
  end

  def get_from_move
    loop do
      puts "Choose a platform to remove. 'A', 'B', or 'C'"
      move_from = gets.chomp.downcase

      if %w(a b c).include?(move_from)
        if @towers[@@platform_index[move_from]].empty?
          puts 'There is nothing on that platform! Please try again.'
          puts ''
          redo
        end

        return @@platform_index[move_from]
      else
        return false unless execute_command(move_from)
      end
    end
  end

  def get_to_move(move_from)
    removed_seg = @towers[move_from].last
    loop do
      puts "Choose a platform to place this '#{removed_seg}' segment. 'A', 'B', or 'C'"
      move_to = gets.chomp.downcase

      if %w(a b c).include?(move_to)
        unless valid_move?(move_from, @@platform_index[move_to])
          puts @@wrong_move_msg.sample
          puts ''
          redo
        end

        return @@platform_index[move_to]
      else
        return false unless execute_command(move_to)
      end
    end
  end

  def move(move_from, move_to)
    @towers[move_to] << @towers[move_from].pop
  end

  def valid_move?(move_from, move_to)
    return false if @towers[move_from].empty? || move_to.nil?
    @towers[move_to].empty? || @towers[move_from].last <= @towers[move_to].last
  end

  def won?
    @towers.count([]) == 2 && @towers.first.empty?
  end
end
