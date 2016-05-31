require './board.rb'

class Game
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
  end

  def run
    until board.over?
      board.render
      take_turn
    end
    board.render
    if board.won?
      puts "You won!"
    else
      puts "You lost!"
    end
  end

  def take_turn
    puts "Pick a position: (0,0)"
    pos = parse_input(gets.chomp)

    board.reaveal_position(pos)
  end

  def parse_input(string)
    string.split(",").map { |char| Integer(char) }
  end

end

Game.new.run
