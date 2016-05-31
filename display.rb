require "colorize"
require_relative "cursorable"

class Display
  include Cursorable

  def initialize
    @cursor_pos = [0,0]
  end

  def get_move(board)
    render(board)
    start_pos, end_pos = nil, nil

    until start_pos && end_pos
      start_pos = get_pos(board)
      board[start_pos].change_selection

      end_pos = get_pos(board)

      if end_pos == start_pos
        board[start_pos].change_selection
        start_pos = nil
      end
    end

    board.move(start_pos, end_pos)
    render(board)

    rescue InvalidMoveError => e
      puts e.message
      retry
  end

  def get_pos(board)
    pos = nil
    until pos
      pos = get_input(board)
      render(board)
    end
    pos
  end

  def render(board)
    system("clear")
    puts "_______________________________"
    build_grid(board).each {|row| puts row.join }
  end

  def build_grid(board)
    board.grid.map.with_index do |row, row_idx|
      row.map.with_index do |piece, col_idx|
        color_options = colors_for(row_idx, col_idx, board)
        piece.to_s.colorize(color_options)
      end
    end
  end

  def colors_for(i, j, board)
    piece = board[[i, j]]
    if piece.is_white?
      color = :red
    else
      color = :blue
    end

    if [i, j] == @cursor_pos
      bg = :light_red
    elsif piece.selected?
      bg = :light_blue
    elsif (i + j).odd?
      bg = :white
    else
      bg = :black
    end
    { background: bg, color: color }
  end

end
