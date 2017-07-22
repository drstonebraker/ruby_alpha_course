class ComputerPlayer
  attr_reader :name, :board

  def initialize(name=nil)
    @name = name || 'Computer'
  end

  def display(board)
    @board = board
  end
end
