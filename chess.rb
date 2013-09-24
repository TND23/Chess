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

class SlidingPiece < Piece
  def valid_moves
  end
end

class Rook < SlidingPiece
  def move_locations
    move_locations = []
    (0..7).each do |index|
      move_locations << [index, position[1]] << [position[0], index]
    end
    move_locations.delete(position)
    move_locations
  end
end


class Bishop <  SlidingPiece

  def move_locations
    move_locations = []
    x = position[1]
    y = position[0]
    (1..7).each do |index|
      move_locations << [x+index, y + index] << [x+index, y - index]
      move_locations << [x-index, y + index] << [x-index, y - index]
    end
    move_locations.select{|position| position.all?{|num| num >= 0 && num < 8}}
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
    #Write code to make attacking stuff blah
  end
end