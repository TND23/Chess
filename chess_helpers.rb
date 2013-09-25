module ChessHelpers
  def check?(board, color) ## REFACTOR!!!!
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

  def find_king(color)
    board.each do |row|
      row.each do |piece|
        next unless piece
        return piece if piece.color == color && piece.is_a?(King)
      end
    end
  end
end