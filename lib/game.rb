require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_accessor :board, :current_player

  def initialize(player1=HumanPlayer.new, player2=ComputerPlayer.new)
    player1.mark = :X
    player2.mark = :O
    @players = [player1, player2].cycle
    @current_player = @players.next
    @board = Board.new
  end

  def switch_players!
    @current_player = @players.next
  end

  def play_turn
    puts "#{current_player.name}'s turn."
    p board
    @current_player.display(board)
    p move = @current_player.get_move
    @board.place_mark(move, @current_player.mark)
    switch_players!
    p board
  end

  def play
    until board.over?
      play_turn
    end
  end
end
