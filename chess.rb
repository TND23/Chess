class Board
  def initialize
    @board = Array.new(8) {
      Array.new(8)
    }
    populate_chess_board
  end

  private
  def populate_chess_board


  end
end


class Piece
  attr_reader :color, :board, :position

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end
end

class Pawn < Piece
  attr_accessor :first_move

  def initialize(color, board, position)
    super(color,board,position)
    @first_move = true
  end

  def move_locations
    move_locations = []
    case color
    when :black
      move_locations << [position[0] + 1, position[1]]
      move_locations << [position[0] + 2, position[1]] if first_move
    when :white
      move_locations << [position[0] - 1, position[1]]
      move_locations << [position[0] - 2, position[1]] if first_move
    end
    move_locations
    #if color = white then moves can be +1 or +2 (if firstmove) if attacking a piece move is +1 +1 or +1 -1
  end

end