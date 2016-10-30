require_relative 'helpers/translation_helpers'

class SimpleTranslationValidator < AbstractMoveValidator
  include TranslationHelpers

  def validate
    validate_does_not_land_on_opponent
    validate_stays_on_the_board
    validate_does_not_cross_wall
  end
end
