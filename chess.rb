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
      piece.position = [end_pos[0], end_pos[1]]
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
      break if checkmate?(board.board, :white)
      break if checkmate?(board.board, :black)
      puts "- - - - - - - - - - - - - -"
      puts @turn_number % 2 == 0 ? "White to move" : "Black to move"
      board.print_pretty_board
      print "What piece do you want to move? "
      piece_start = gets.chomp.split(',').map(&:to_i)
      print "Where do you want to move to? "
      piece_end = gets.chomp.split(',').map(&:to_i)
      board.move(piece_start, piece_end)


    end
  end
end

b = ChessGame.new
b.play