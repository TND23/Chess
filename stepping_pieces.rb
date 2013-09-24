class SteppingPiece < Piece

end


class King < SteppingPiece
  def move_locations
    move_locations = []
    x = position[1]
    y = position[0]

    move_locations << [x+1, y+1] << [x+1, y-1] << [x-1, y+1] << [x-1, y-1]
    move_locations << [x+1, y] << [x-1, y] << [x, y+1] << [x, y-1]
    move_locations.select{|position| position.all?{|num| num >= 0 && num < 8}}
  end
end

class Knight < SteppingPiece
  def move_locations
    delta_move = [[2,1], [-2,1], [2,-1], [-2,-1], [1,2],
                  [1,-2], [-1,2], [-1,-2]]
    x = position[1]
    y = position[0]
    move_locations = []
    delta_move.each do |delta_x, delta_y|
      move_locations << [delta_x + x, delta_y + y]
    end
    move_locations.select{|position| position.all?{|num| num >= 0 && num < 8}}
  end
end
