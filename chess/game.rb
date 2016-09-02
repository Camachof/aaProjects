require_relative "manifest"

class Game

  def initialize(board, display)
    @board, @display = board, display
  end

  def play
    flag = false
    until false
      @display.get_move(@board)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  display = Display.new
  board = Board.new
  game = Game.new(board, display)
  game.play
end
