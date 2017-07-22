require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_reader :board

  def initialize(player1, player2)
    @players = [player1, player2].cycle
    @current_player = @players.next
    @board = Board.new
  end

  def switch_players!
    @current_player = @players.next
  end

  def play_turn
    @current_player.display(board)
    board.place_mark(@current_player.get_move)
  end
end
