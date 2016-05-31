require "singleton"

class NullPiece
  include Singleton

  def to_s
    "   "
  end

  def selected?
    false
  end

  def change_selection
  end

  def is_white?
  end

  def dup(new_board)
    NullPiece.instance
  end

end
