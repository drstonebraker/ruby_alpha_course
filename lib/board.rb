class Board
  attr_reader :grid

  def self.default_grid
    Array.new(10){Array.new(10)}
  end

  def initialize(grid=Board.default_grid)
    @grid = grid
  end
end
