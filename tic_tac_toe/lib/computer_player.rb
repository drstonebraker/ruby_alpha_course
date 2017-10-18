class ComputerPlayer
  attr_reader :name, :board
  attr_accessor :mark

  def initialize(name=nil)
    @name = name || 'Computer'
  end

  def display(board)
    @board = board
  end

  def get_move
    winner = board.winning_moves(mark).sample
    random = board.available_moves.sample
    winner || random
  end

  private




end
