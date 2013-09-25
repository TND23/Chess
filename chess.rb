load './pieces.rb'
load './sliding_pieces.rb'
load './stepping_pieces.rb'

class Board
  attr_reader :board

  def initialize
    @board = Array.new(8) {
      Array.new(8)
    }
    populate_chess_board
  end

  def check?(color)
    king_pos = find_king(color).position

    board.each do |row|
      row.each do |piece|
        next unless piece
        next if piece.color == color
        return true if piece.valid_moves.include?(king_pos)
      end
    end
    false
  end

  def checkmate?
    if check?(:white)


    elsif check?(:black)
    end
  end

  def move(current_pos, end_pos)
    piece = board[current_pos[0]][current_pos[1]]
    if piece.valid_move?(end_pos)
      board[current_pos[0]][current_pos[1]] = nil
      board[end_pos[0]][end_pos[1]] = piece
    else
      print "You cannot move there, try again"
      false
    end
  end

  private

  def find_king(color)
    board.each do |row|
      row.each do |piece|
        next unless piece
        return piece if piece.color == color && piece.is_a?(King)
      end
    end
  end

  def populate_chess_board
    8.times { |index|  board[1][index] = Pawn.new(:black,board, [1,index]) }
    8.times { |index|  board[6][index] = Pawn.new(:white,board, [6,index]) }
   # board[2][1] = King.new(:white, nil, [2,1])
    [0,7].each do |row|
      color = (row == 0) ? :black : :white
      (0..7).each do |column|
        board[row][column] = case column
                             when 4 then King.new(color,board,[row,column])
                             when 3 then Queen.new(color,board,[row,column])
                             when 0, 7 then Rook.new(color,board,[row,column])
                             when 1, 6 then Knight.new(color,board,[row,column])
                             when 2, 5 then Bishop.new(color,board,[row,column])
                             end
      end
    end
  end
end
 #opp_color == :white ? :black : :white
b = Board.new
p "Board before #{b.board[2][1]}\n"
b.move([1,1], [2,1])
print b.board[2][1]


# r = Rook.new(:black, b.board, [0,0])
# p r.picture
# #
# # pawn = Pawn.new(:white, b.board, [1,0])
# # p pawn.picture
# # p pawn.move_locations
#
# #b.board[2][5] = King.new(:white, b.board, [2,1])
# # p queen.move_locations
# p b.check?(:white)
#
# # bishop = Bishop.new(:black, b.board, [2,3])
# # p bishop.move_locations
#
# king = King.new(:black, b.board, [0,4])
# p king.picture
#
#
#
# # def print_board
# #   board.each do |row|
# #     row.each do |piece|
# #       puts piece.class
# #       print piece.position if piece
# #       puts " "
# #     end
# #   end
# # end




