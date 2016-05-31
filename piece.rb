class Piece
  attr_accessor :position

  def initialize(pos, is_white, board)
    @selected = false
    @position = pos
    @is_white = is_white
    @board = board
  end

  def to_s
    " x "
  end

  def change_selection
    @selected = !@selected
  end

  def selected?
    @selected
  end

  def is_white?
    @is_white
  end

  def valid_moves
    valid_moves = []
    moves.each do |pos|
      valid_moves << pos unless move_into_check?(pos)
    end
    valid_moves
  end

  def move_into_check?(potential_pos)
    color = is_white? ? :w : :b
    test_board = @board.dup
    test_board.move(@position, potential_pos)
    test_board.in_check?(color)
  end

end
