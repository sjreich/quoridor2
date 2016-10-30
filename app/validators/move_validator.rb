class MoveValidator < AbstractMoveValidator
  def validate
    next_validator.validate
  end

  private

  def next_validator
    if move.translation?
      TranslationValidator.new(move, prior_game_state)
    elsif move.wall?
      WallValidator.new(move, prior_game_state)
    end
  end
end
