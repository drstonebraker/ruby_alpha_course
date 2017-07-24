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

  def full?
    count == grid.inject(0) {|memo, row| memo + row.size}
  end

  def place_random_ship
    empty_positions = grid.flat_map.with_index do |row, row_idx|
      row.map.with_index do |space, space_idx|
        space.nil? ? [row_idx, space_idx] : nil
      end
    end
    empty_positions.compact!
    place_ship(empty_positions.sample)
  end

  def place_ship(pos=nil)
    if pos
      self[pos] = :s
    else
      random_ship
    end
    self
  end

  def won?
    empty?
  end

  def place_mark(pos)
    self[pos] = :x
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, sym)
    row, col = pos
    grid[row][col] = sym
  end
end
