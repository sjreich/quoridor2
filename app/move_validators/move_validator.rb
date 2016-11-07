class MoveValidator < AbstractMoveValidator
  def validate
    next_validator.new(move, prior_game_state).validate
  end

  private

  def next_validator
    return TranslationValidator if move.translation?
    return WallValidator if move.wall?
  end
end
