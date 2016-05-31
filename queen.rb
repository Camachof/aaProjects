class Queen < SlidingPiece

  def move_dirs
    { diag: true, straight: true }
  end

  def to_s
    " Q "
  end

  def dup(new_board)
    Queen.new(@position.dup, @is_white, new_board)
  end

end
