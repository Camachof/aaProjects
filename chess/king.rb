class King < SteppingPiece

  def move_dirs
    { multi: true, l: false }
  end

  def to_s
    " K "
  end

  def dup(new_board)
    King.new(@position.dup, @is_white, new_board)
  end

end
