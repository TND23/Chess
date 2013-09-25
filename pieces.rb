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

  def opposite_color
    color == :white ? :black : :white
  end
end

class Pawn < Piece
  attr_accessor :first_move

  def initialize(color, board, position)
    super(color,board,position)
    @first_move = true
  end

  def valid_move?(pos)
    return true unless board[pos[0]][pos[1]]
  end

  def valid_moves
    move_locations.select{|pos| valid_move?(pos) } + attacking_moves
  end

  def attacking_moves
    attacking_moves = []
    move_locations.each do |row,col|
      begin
        if board[row][col+1].color == opposite_color
          attacking_moves << [row, col+1]
        elsif board[row][col-1].color == opposite_color
          attacking_moves << [row, col-1]
        end
      rescue
      end
    end
    attacking_moves
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
  end
end
