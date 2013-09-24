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
    print_board
  end

  def print_board
    board.each do |row|
      row.each do |piece|
        puts piece.class
        print piece.position if piece
        puts " "
      end
    end
  end

  def check?(color)
    king_pos = find_king(color).position

    board.each do |row|
      row.each do |piece|
        next unless piece
        next if piece.color == color
        p piece
        print piece.move_locations
        return true if piece.move_locations.include?(king_pos)
      end
    end
    false
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
    8.times { |index|  board[1][index] = Pawn.new(:black,nil, [1,index]) }
    8.times { |index|  board[6][index] = Pawn.new(:white,nil, [6,index]) }
   # board[2][1] = King.new(:white, nil, [2,1])
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
 #opp_color == :white ? :black : :white
b = Board.new
p b.check?(:white)

