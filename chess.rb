require './pieces.rb'
require './sliding_pieces.rb'
require './stepping_pieces.rb'

class Board
  attr_reader :board

  def initialize
    @board = Array.new(8) {
      Array.new(8)
    }
    populate_chess_board
  end

  # def [](x, y)
  #   @board[y][x]
  # end
  #
  # def [](x, y)
  #   board[y][x]
  # end

 # private
  def populate_chess_board
    8.times { |index|  board[1][index] = Pawn.new(:black,nil, [1,index]) }
    8.times { |index|  board[6][index] = Pawn.new(:white,nil, [1,index]) }

    [0,7].each do |row|
      color = (row == 0) ? :black : :white
      (0..7).each do |column|
        board[row][column] = case column
                             when 4 then King.new(color,nil,[row,column])
                             when 3 then Queen.new(color,nil,[row,column])
                             when 0, 7 then Rook.new(color,nil,[row,column])
                             when 1, 6 then Knight.new(color,nil,[row,column])
                             when 2, 5 then Bishop.new(color,nil,[row,column])
                             end
      end
    end
  end
end

b = Board.new

print b.board

