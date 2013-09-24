require './sliding_pieces.rb'
require './pieces.rb'

class Board
  def initialize
    @board = Array.new(8) {
      Array.new(8)
    }
    populate_chess_board
  end

  private
  def populate_chess_board
  end
end

