class Tile
  attr_reader :is_hidden, :is_bomb
  attr_accessor :adj_bombs

  def initialize(is_bomb = false)
    @is_hidden = true
    @is_bomb = is_bomb
    @adj_bombs = 0
  end

  def to_s
    return " * " if is_hidden
    return " B " if is_bomb
    return " _ " if adj_bombs == 0
    " #{adj_bombs} "
  end

  def reveal
    @is_hidden = false
  end

  def is_showing
    !is_hidden
  end
end
