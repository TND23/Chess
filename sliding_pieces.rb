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
      move_locations << [y+index, x + index] << [y+index, x - index]
      move_locations << [y-index, y + index] << [y-index, y - index]
    end
    move_locations.select{|position| position.all?{|num| num >= 0 && num < 8}}
  end
end

class Queen < SlidingPiece
  def move_locations
    move_locations = []
    move_locations += Bishop.new(nil, nil, position).move_locations
    move_locations += Rook.new(nil, nil, position).move_locations
    move_locations
  end
end

