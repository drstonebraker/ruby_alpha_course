require_relative './board.rb'

class GameNode
  attr_accessor :children
  attr_reader :board, :mark

  def initialize(board, mark)
    @board = board
    @mark = mark
  end

  def add_child(child)
    children << child
  end

  def end_state?
    board.over?
  end

  def get_children
    board.available_moves.map do |pos|
      new_board = board.copy
      new_board[pos] = mark
      new_board
    end
  end

end
