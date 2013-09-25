load './chess_helpers.rb'
load './pieces.rb'
load './sliding_pieces.rb'
load './stepping_pieces.rb'

class Board
  include ChessHelpers
  attr_reader :board

  def initialize
    @board = Array.new(8) {
      Array.new(8)
    }
    populate_chess_board
    print_pretty_board
  end

  def print_pretty_board
    print "   "
    8.times { |i| print "[#{i}]"}
    board.each_with_index do |row, index|
      print "\n[#{index}]"
      row.each do |piece|
        print "[#{piece.picture}]" if piece
        print "[ ]" unless piece
      end
      puts ""
    end
    nil
  end

  def move(current_pos, end_pos)
    piece = board[current_pos[0]][current_pos[1]]
    if piece.valid_move?(end_pos)
      board[current_pos[0]][current_pos[1]] = nil
      board[end_pos[0]][end_pos[1]] = piece
      p piece
    else
      puts "You cannot move there, try again"
      false
    end
  end

  private

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

class ChessGame
  include ChessHelpers
  attr_reader :board

  def initialize
    @board = Board.new
    @turn_number = 0
  end

  def play
    loop do
      puts "- - - - - - - - - - - - - -"
      puts @turn_number % 2 == 0 ? "White to move" : "Black to move"
      board.print_pretty_board
      print "What piece do you want to move? "
      piece_start = gets.chomp.split(',').map(&:to_i)
      print "Where do you want to move to? "
      piece_end = gets.chomp.split(',').map(&:to_i)
      board.move(piece_start, piece_end)

      puts "--debugging---"
      puts "Check: #{check?(board.board, :white)}, #{check?(board.board, :black)}\n"
      puts "Checkmates: #{checkmate?(board.board, :white)}, #{checkmate?(board.board, :black)}\n"
      break if checkmate?(board.board, :black)
      break if checkmate?(board.board, :white)
    end
  end
end

 #opp_color == :white ? :black : :white
b = ChessGame.new
b.play

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




