class Board
  attr_reader :grid, :trios

  def initialize(grid=nil)
    @grid = grid || [
      [nil,nil,nil],
      [nil,nil,nil],
      [nil,nil,nil]
    ]
    @trios = {
      r0: [[0,0],[0,1],[0,2]],
      r1: [[1,0],[1,1],[1,2]],
      r2: [[2,0],[2,1],[2,2]],
      c0: [[0,0],[1,0],[2,0]],
      c1: [[0,1],[1,1],[2,1]],
      c2: [[0,2],[1,2],[2,2]],
      d0: [[0,0],[1,1],[2,2]],
      d1: [[0,2],[1,1],[2,0]]
    }
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

  def over?
    winner || full?
  end

  def winning_move?(pos, mark)
    winning_moves(mark).include?(pos)
  end

  def winning_moves(mark)
    winning_trios = trios.select do |k, positions|
      trio = positions.map{|pos| grid.dig(*pos)}
      trio.count(mark) == 2 && trio.count(nil) == 1
    end
    winning_trios.values.map do |positions|
      positions.find {|pos| grid.dig(*pos).nil?}
    end
  end

  def available_moves
    trios.values.flatten(1).uniq.select do |pos|
      self[pos].nil?
    end
  end

  def copy
    Board.new(grid)
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

  def full?
    @grid.none? {|row| row.any?(&:nil?) } && 'Game Over'
  end


end
