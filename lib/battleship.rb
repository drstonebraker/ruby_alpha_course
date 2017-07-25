class BattleshipGame
  attr_reader :board, :player

  def initialize(player, board)
    @player = player
    @board = board
  end

  def attack(*pos)
    board[pos] = :x

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
end
