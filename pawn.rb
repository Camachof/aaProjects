class Pawn < Piece

  # check if first move

  WHITE = [[-1,-1], [-1,1], [-1,0]]
  BLACK = [[1,1], [1,-1], [1,0]]

  def moves
    moves = []
    if @is_white
      moves.concat(collect_path_moves(WHITE))
    else
      moves.concat(collect_path_moves(BLACK))
    end
    moves
  end

  def collect_path_moves(direction)

    collected_path = []
    directions = move_dirs(direction)
    directions.each do |diff|
      row, col = @position
      x, y = diff
      new_move = [row += x, col += y]

      if valid_path_move?(new_move)
        collected_path << new_move
      elsif valid_capture?(new_move)
        collected_path << new_move
      end


    end
    collected_path
  end

  def valid_path_move?(new_move)
    @board.in_bounds?(new_move) &&
    @board[new_move] == NullPiece.instance &&
    @position[1] == new_move[1]
  end

  def valid_capture?(new_move)
    @board.in_bounds?(new_move) &&
    @position[1] != new_move[1] &&
    @board[new_move].is_white? != @is_white &&
    @board[new_move].is_a?(Piece)
  end

  def to_s
    " P "
  end

  def move_dirs(directions)
    row = @position[0]
    move_directions = directions.dup
    if @is_white && row == 6
      move_directions << [-2, 0]
    elsif !@is_white && row == 1
      move_directions << [2, 0]
    end
    move_directions
  end

  def dup(new_board)
    Pawn.new(@position.dup, @is_white, new_board)
  end

end
