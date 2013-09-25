class SlidingPiece < Piece
  def valid_move?(pos)
    #Refactor
    return true unless board[pos[0]]
    if board[pos[0]][pos[1]]
      if self.color == board[pos[0]][pos[1]].color
        return false
      end
    end
    true
  end

  def valid_moves
    move_locations
  end
end

class Rook < SlidingPiece
  def initialize(color, board, position)
    super(color, board, position)
    @picture = color == :white ? "\u{2656}" : "\u{265C}"
  end

  def move_locations
    move_locations = []
    (0..7).each do |index|
      #if board[index,position[index]] == PIECE of any kind
      #Break
      if valid_move?([index, position[1]])
        move_locations << [index, position[1]]
      else
        break
      end
    end

    (0..7).each do |index|
      if valid_move?([position[0], index])
        move_locations << [position[0], index]
      else
        break
      end
    end
    move_locations.delete(position)
    move_locations
  end
end

class Bishop <  SlidingPiece
  def initialize(color, board, position)
    super(color, board, position)
    @picture = color == :white ? "\u{2657}" : "\u{265D}"
  end

  def move_locations
    move_locations = []
    x = position[1]
    y = position[0]

    (1..7).each do |index|
      if valid_move?([y+index, x + index])
        move_locations << [y+index, x + index]
      else
        break
      end
    end

    (1..7).each do |index|
      if valid_move?([y-index, x + index])
        move_locations <<  [y-index, x + index]
      else
        break
      end
    end

    (1..7).each do |index|
      if valid_move?([y+index, x - index])
        move_locations <<  [y+index, x - index]
      else
        break
      end
    end

    (1..7).each do |index|
      if valid_move?([y-index, x-index])
        move_locations <<  [y-index, x - index]
      else
        break
      end
    end


    move_locations.select{|position| position.all?{|num| num >= 0 && num < 8}}
  end
end

class Queen < SlidingPiece
  def initialize(color, board, position)
    super(color, board, position)
    @picture = color == :white ? "\u{2655}" : "\u{265B}"
  end

  def move_locations
    move_locations = []
    move_locations += Bishop.new(nil, board, position).move_locations
    move_locations += Rook.new(nil, board, position).move_locations
    move_locations
  end
end

