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

  def empty?(pos)
    self[pos].nil?
  end

  def winner
    return :X if winner?(:X)
    return :O if winner?(:O)
    nil
  end
  private

  def winner?(mark)
    check_rows = ->(row) { row.all?{|space| space == mark } }
    row_winner = @grid.any?(&check_rows)
    col_winner = @grid.transpose.any?(&check_rows)
    d1_winner = [self[[0,0]], self[[1,1]], self[[2,2]]].all? {|space| space == mark }
    d2_winner = [self[[0,2]], self[[1,1]], self[[2,0]]].all? {|space| space == mark }
    row_winner || col_winner || d1_winner || d2_winner
  end
end
