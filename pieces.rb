class Piece
  attr_reader :color, :board, :position

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def valid_move?(pos)
    if self.move_locations.include?(pos)


      #Check if you are in check

    else
      false
    end
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
    #Write code to make attacking stuff and ensure cannot take in front
  end
end
