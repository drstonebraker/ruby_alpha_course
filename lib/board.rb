class Board
  attr_reader :grid

  def initialize(grid=nil)
    @grid = grid || [
      [nil,nil,nil],
      [nil,nil,nil],
      [nil,nil,nil]
    ]
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  alias :place_mark :[]=
end
