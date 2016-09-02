class SteppingPiece < Piece

  MULTI = [[-1,-1], [-1,1], [1,1], [1,-1],[-1,0], [1,0], [0,-1], [0,1]]
  L = [[-1,2], [-1,-2], [1,2], [1,-2], [-2,1], [-2,-1], [2,1], [2,-1]]

  def moves
    direction = move_dirs
    moves = []
    moves.concat(collect_path_moves(MULTI)) if direction[:multi]
    moves.concat(collect_path_moves(L)) if direction[:l]
    moves
  end

  def collect_path_moves(direction)
    collected_path = []
    direction.each do |diff|
      row, col = @position
      x, y = diff
      new_move = [row += x, col += y]
      collected_path << new_move if valid_path_move?(new_move)
    end
    collected_path
  end

  def valid_path_move?(new_move)
    @board.in_bounds?(new_move) &&
    ( @board[new_move] == NullPiece.instance ||
    @board[new_move].is_white? != @is_white )
  end

end
