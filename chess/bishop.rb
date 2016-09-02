class Bishop < SlidingPiece

  def move_dirs
    { diag: true, staight: false }
  end

  def to_s
    " B "
  end

  def dup(new_board)
    Bishop.new(@position.dup, @is_white, new_board)
  end

end
