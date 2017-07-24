class Board
  attr_reader :grid

  def self.default_grid
    Array.new(10){Array.new(10)}
  end

  def initialize(grid=Board.default_grid)
    @grid = grid
  end

  def count
    grid.inject(0) do |memo, row|
      memo + row.count(:s)
    end
  end

  def empty?(pos=nil)
    if pos
      grid.dig(*pos).nil?
    else
      count.zero?
    end
  end
end
