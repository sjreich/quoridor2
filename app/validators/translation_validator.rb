class TranslationValidator < AbstractMoveValidator
  def validate
    validate_not_wildly_illegal
    return unless move.errors[:base].empty?
    next_validator.validate
  end

  private

  def next_validator
    if move.simple_translation?
      SimpleTranslationValidator.new(move, prior_game_state)
    elsif move.straight_jump?
      StraightJumpValidator.new(move, prior_game_state)
    elsif move.diagonal_jump?
      DiagonalJumpValidator.new(move, prior_game_state)
    end
  end

  def validate_not_wildly_illegal
    return if move.simple_translation?
    return if move.straight_jump?
    return if move.diagonal_jump?
    move.errors[:base] << 'No way.'
  end
end
