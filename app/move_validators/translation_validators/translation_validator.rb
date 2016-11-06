class TranslationValidator < AbstractMoveValidator
  def validate
    validate_not_wildly_illegal
    return unless move.errors[:base].empty?
    next_validator.new(move, prior_game_state).validate
  end

  private

  def next_validator
    return SimpleTranslationValidator if move.simple_translation?
    return StraightJumpValidator if move.straight_jump?
    return DiagonalJumpValidator if move.diagonal_jump?
  end

  def validate_not_wildly_illegal
    return if move.simple_translation?
    return if move.straight_jump?
    return if move.diagonal_jump?
    move.errors[:base] << 'No way.'
  end
end
