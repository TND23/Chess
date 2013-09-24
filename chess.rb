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

    board[0][4] = King.new(:black, nil,[0,4])
    board[7][4] = King.new(:white, nil,[7,4])

    board[0][3] = Queen.new(:black, nil, [0,3])
    board[7][3] = Queen.new(:white, nil, [7,3])

    board[0][0] = Rook.new(:black, nil,[0,0])
    board[0][7] = Rook.new(:black, nil,[0,7])
    board[7][0] = Rook.new(:white, nil,[7,0])
    board[7][7] = Rook.new(:white, nil,[7,7])

    board[0][1] = Knight.new(:black, nil,[0,1])
    board[0][6] = Knight.new(:black, nil,[0,6])
    board[7][1] = Knight.new(:white, nil,[7,1])
    board[7][6] = Knight.new(:white, nil,[7,6])

    board[0][2] = Bishop.new(:black, nil,[0,2])
    board[0][5] = Bishop.new(:black, nil,[0,5])
    board[7][2] = Bishop.new(:white, nil,[7,2])
    board[7][5] = Bishop.new(:white, nil,[7,5])

  end
end

b = Board.new

print b.board

