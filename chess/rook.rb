class Rook < SlidingPiece

  def move_dirs
    { diag: false, straight: true }
  end

  def to_s
    " R "
  end

  def dup(new_board)
    Rook.new(@position.dup, @is_white, new_board)
  end

end
