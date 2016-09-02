class SlidingPiece < Piece

  DIAGONAL = [[-1,-1], [-1,1], [1,1], [1,-1]]
  STRAIGHT = [[-1,0], [1,0], [0,-1], [0,1]]

  def moves
    direction = move_dirs
    moves = []
    moves.concat(collect_path_moves(DIAGONAL)) if direction[:diag]
    moves.concat(collect_path_moves(STRAIGHT)) if direction[:straight]
    moves
  end

  def collect_path_moves(direction)
    collected_path = []
    direction.each do |diff|
      row, col = @position
      while true
        x, y = diff
        new_move = [row += x, col += y]

        if valid_path_move?(new_move)
          collected_path << new_move
        elsif valid_capture?(new_move)
          collected_path << new_move
          break
        else
          break
        end

      end
    end
    collected_path
  end

  def valid_path_move?(new_move)
    @board.in_bounds?(new_move) &&
    @board[new_move] == NullPiece.instance
  end

  def valid_capture?(new_move)
    @board.in_bounds?(new_move) &&
    @board[new_move].is_white? != @is_white
  end

end
