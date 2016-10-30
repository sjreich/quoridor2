class FirstPseudoMoveValidator < AbstractMoveValidator
  include TranslationHelpers

  def validate
    validate_lands_on_opponent
    validate_stays_on_the_board
    validate_does_not_cross_wall
  end
end
