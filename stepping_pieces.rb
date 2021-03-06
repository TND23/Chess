class SteppingPiece < Piece
  def valid_move_stepping?(pos)
    return true unless board[pos[0]]
    if board[pos[0]][pos[1]] && self.color == board[pos[0]][pos[1]].color
      false
    else
      true
    end
  end

  def valid_moves
    move_locations.select{|pos| valid_move_stepping?(pos)}
  end
end


class King < SteppingPiece
  def initialize(color, board, position)
    super(color, board, position)
    @picture = color == :white ? "\u{2654}" : "\u{265A}"
  end

  def move_locations
    move_locations = []
    y = position[1]
    x = position[0]

    move_locations << [x+1, y+1] << [x+1, y-1] << [x-1, y+1] << [x-1, y-1]
    move_locations << [x+1, y] << [x-1, y] << [x, y+1] << [x, y-1]
    move_locations.select{|position| position.all?{|num| num >= 0 && num < 8}}
  end
end

class Knight < SteppingPiece
  def initialize(color, board, position)
    super(color, board, position)
    @picture = color == :white ? "\u{2658}" : "\u{265E}"
  end

  def move_locations
    delta_move = [[2,1], [-2,1], [2,-1], [-2,-1], [1,2],
                  [1,-2], [-1,2], [-1,-2]]
    y = position[1]
    x = position[0]
    move_locations = []
    delta_move.each do |delta_x, delta_y|
      move_locations << [delta_x + x, delta_y + y]
    end
    move_locations.select{|position| position.all?{|num| num >= 0 && num < 8}}
  end
end
