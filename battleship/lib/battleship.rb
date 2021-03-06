require_relative 'board'
require_relative 'player'

class BattleshipGame
  attr_reader :board, :player

  def initialize(player=HumanPlayer.new, board=Board.new)
    @player = player
    @board = board
    @turn_count = 0
  end

  def attack(pos)
    hit_or_miss_msg(pos)
    board[pos] = :x
  end

  def hit_or_miss_msg(pos)
    if board[pos].nil?
      puts miss_msg
    elsif board[pos] == :s
      puts hit_msg
      return true
    end
    false
  end

  def miss_msg
    "It's a miss"
  end

  def hit_msg
    "It's a hit!"
  end

  def count
    board.count
  end

  def game_over?
    board.won?
  end

  def play_turn
    @turn_count += 1
    pos = player.get_play
    attack(pos)
  end

  def play
    board.place_random_ship(10)

    play_turn until game_over?
    puts win_msg
  end

  def win_msg
    "You've sunk all the ships in #{@turn_count} turns!"
  end
end
