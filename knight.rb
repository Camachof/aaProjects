class Knight < SteppingPiece

  def move_dirs
    { multi: false, l: true }
  end

  def to_s
    " k "
  end

  def dup(new_board)
    Knight.new(@position.dup, @is_white, new_board)
  end

end
