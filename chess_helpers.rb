module ChessHelpers
  def check?(board, color) ## REFACTOR!!!!
    king_pos = find_king(board, color).position

    board.each do |row|
      row.each do |piece|
        next unless piece
        next if piece.color == color
        return true if piece.valid_moves.include?(king_pos)
      end
    end
    false
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
        next unless piece
        # print piece.valid_moves
        next if piece.opposite_color == color
        # print piece.valid_moves
        return false if piece.valid_moves.any? { |pos| piece.valid_move?(pos)}

      end
    end
    return true
  end

end