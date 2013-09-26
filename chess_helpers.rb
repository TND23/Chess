module ChessHelpers
  def check?(board, color)

    king_pos = find_king(board,color).position

    board.each do |row|
      row.each do |piece|
        next unless piece
        next if piece.color == color
        return true if piece.valid_moves.include?(king_pos)
        #iterate through the moves that can block, and then see
      end
    end
    return false
    # rescue
    #   puts "Checkmate"
    #   exit
    # end
  end

  def find_king(board, color)
    board.each do |row|
      row.each do |piece|
        next unless piece
        return piece if piece.color == color && piece.is_a?(King)
      end
    end
  end

  def checkmate?(board, color)
    return false unless check?(board, color)
    board.each do |row|
      row.each do |piece|
        next if !piece || piece.opposite_color == color
        piece.valid_moves.each do |position|
          return false if piece.valid_move?(position)
        end
      end
    end
    true
  end

  def deep_dup(board)
    deep_dup = Array.new(8){ Array.new(8) }

    board.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        deep_dup[row_index][col_index] =  piece ? piece.dup : nil
      end
    end
    deep_dup
  end

end