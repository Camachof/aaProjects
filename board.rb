class Board

  def initialize
    generate_board
  end

  def generate_board
    @grid = Array.new(8) { Array.new(8)}

    [[0,0], [0,7]].each {|pos| self[pos] = Rook.new(pos, false, self)}
    [[7,0], [7,7]].each {|pos| self[pos] = Rook.new(pos, true, self)}
    [[0,1], [0,6]].each {|pos| self[pos] = Knight.new(pos, false, self)}
    [[7,1], [7,6]].each {|pos| self[pos] = Knight.new(pos, true, self)}
    [[0,2], [0,5]].each {|pos| self[pos] = Bishop.new(pos, false, self)}
    [[7,2], [7,5]].each {|pos| self[pos] = Bishop.new(pos, true, self)}
    self[[0,3]] = Queen.new([0,3], false, self)
    self[[7,3]] = Queen.new([7,3], true, self)
    self[[0,4]] = King.new([0,4], false, self)
    self[[7,4]] = King.new([7,4], true, self)

    (1..6).each do |row_idx|
      (0..7).each do |col_idx|
        pos = [row_idx, col_idx]

        case row_idx
        when 6
          self[pos] = Pawn.new(pos, true, self)
        when 1
          self[pos] = Pawn.new(pos, false, self)
        else
          self[pos] = NullPiece.instance
        end

      end
    end
    @grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  def move(start_pos, end_pos)
    piece = self[start_pos]
    piece.change_selection

    valid_move(start_pos, end_pos)

    piece.position = end_pos
    self[end_pos] = piece
    self[start_pos] = NullPiece.instance
  end

  def valid_move(start_pos, end_pos)
    starting_piece = self[start_pos]

    raise InvalidMoveError unless
      starting_piece.is_a?(Piece) &&
      starting_piece.moves.include?(end_pos)
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, @grid.length - 1) }
  end

  def grid
    @grid
  end

  def in_check?(color)
    kings_spot = find_king(color)
    @grid.each do |row|
      row.each do |piece|
        return true if piece.moves.include?(kings_spot)
      end
    end
    false
  end

  def find_king(color)
    color_matches = color == :w ? true : false
    @grid.each do |row|
      row.each do |piece|
        return piece.position if piece.is_a?(King) && piece.is_white? == color_matches
      end
    end
  end

  def checkmate?
    # needs fixing!!!
    in_check?(color) && any_valid_moves?(color)
  end

  def any_valid_moves?(color)
    @grid.each do |row|
      row.each do |piece|
        return false unless piece.valid_moves.empty?
      end
    end
    true
  end

  def dup
    new_board = Board.new
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        new_board[[row_idx, col_idx]] = piece.dup(new_board)
      end
    end
    new_board
  end

end

class InvalidMoveError < StandardError
  attr_reader :message
  def initialize
    @message = "Invalid move!"
  end
end
