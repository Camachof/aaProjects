require './tile.rb'

class Board
  attr_reader :grid

  CHANCE_FOR_BOMB = 10
  BOARD_SIZE = 9

  def self.default_grid
    Array.new(BOARD_SIZE) do
      Array.new(BOARD_SIZE) do
        is_bomb = rand(CHANCE_FOR_BOMB) == 0
        Tile.new(is_bomb)
      end
    end
  end

  def initialize(grid = Board.default_grid)
    @grid = grid
    look_for_adj_bombs
  end

  def look_for_adj_bombs
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        pos = [row_idx, col_idx]
        adj_bombs = 0

        adj_pos(pos).each do |adj_pos|
          adj_bombs += 1 if self[adj_pos].is_bomb
        end

        tile.adj_bombs = adj_bombs
      end
    end
  end

  def adj_pos(pos)
    row, col = pos
    adj_pos = [[row - 1, col],
    [row - 1, col + 1],
    [row, col + 1],
    [row + 1, col + 1],
    [row + 1, col],
    [row + 1, col - 1],
    [row, col - 1],
    [row - 1, col - 1]]

    adj_pos.select { |pos| valid_pos?(pos) }
  end

  def valid_pos?(pos)
    row, col = pos
    row.between?(0, BOARD_SIZE - 1) && col.between?(0, BOARD_SIZE - 1)
  end

  def render
    puts "    #{(0..8).to_a.join("  ")}"
    puts "    #{'-' * 25}"
    grid.each_with_index do |row, row_idx|
      print "#{row_idx} |"
      row.each do |tile|
        print tile.to_s
      end
      puts
    end
  end

  def over?
    lost? || won?
  end

  def lost?
    grid.each do |row|
      row.each do |tile|
        return true if tile.is_showing && tile.is_bomb
      end
    end
    false
  end

  def won?
    grid.each do |row|
      row.each do |tile|
        return false if tile.is_showing && tile.is_bomb
        return false if tile.is_hidden && !tile.is_bomb
      end
    end
    true
  end

  def reaveal_position(pos)
    tile = self[pos]
    return if tile.is_showing

    tile.reveal

    return if tile.adj_bombs >= 1 || tile.is_bomb

    adj_pos(pos).each do |adj_pos|
      reaveal_position(adj_pos)
    end
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end
end
