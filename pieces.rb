class Piece
  include ChessHelpers
  attr_reader :color, :board, :picture
  attr_accessor :position

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def valid_move?(end_pos)
    if valid_moves.include?(end_pos)
      duped_board = deep_dup(board)
      duped_board[self.position[0]][self.position[1]] = nil

      self_dup = self.piece_deep_dup(duped_board, end_pos)

      duped_board[end_pos[0]][end_pos[1]] = self_dup
      return check?(duped_board, color) ? false : true
    end
  end

  def opposite_color
    color == :white ? :black : :white
  end

  def piece_deep_dup(board, pos)
    self.class.new(color, board, pos)
  end

end

class Pawn < Piece
  attr_accessor :first_move

  def initialize(color, board, position)
    super(color,board,position)
    @picture = color == :white ? "\u{2659}" : "\u{265F}"
  end

  def valid_move_pawn?(pos)
    return true unless board[pos[0]][pos[1]]
  end

  def valid_moves
    move_locations.select{|pos| valid_move_pawn?(pos) } + attacking_moves
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
      move_locations << [position[0] + 1, position[1]] unless board[position[0] + 1][position[1]]
      move_locations << [position[0] + 2, position[1]] if first_move?
    when :white
      move_locations << [position[0] - 1, position[1]] unless board[position[0] - 1][position[1]]
      move_locations << [position[0] - 2, position[1]] if first_move?
    end
    move_locations
  end

  def first_move?
    case color
    when :white
      return true if position[0] == 6
    when :black
      return true if position[0] == 1
    end
    false
  end
end