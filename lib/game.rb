require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_reader :board, :current_player

  def initialize(player1=HumanPlayer.new, player2=ComputerPlayer.new)
    @players = [player1, player2].cycle
    @current_player = @players.next
    @board = Board.new
  end

  def switch_players!
    @current_player = @players.next
  end

  def play_turn
    puts "#{current_player}'s turn."
    @current_player.display(board)
    board.place_mark(@current_player.get_move, @current_player.mark)
    switch_players!
  end

  def play
    until board.over?
      play_turn
    end
  end
end
