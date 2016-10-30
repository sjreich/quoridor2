require_relative 'helpers/translation_helpers'

class StraightJumpValidator < AbstractMoveValidator
  include TranslationHelpers

  def validate
    first_move = PseudoMove.new(x: move.x / 2, y: move.y / 2, variety: :translation, player: move.player)
    FirstPseudoMoveValidator.new(first_move, prior_game_state).validate

    second_move = PseudoMove.new(x: move.x / 2, y: move.y / 2, variety: :translation, player: move.player)
    current_player_info[:position] = position_after(first_move)
    SimpleTranslationValidator.new(second_move, prior_game_state).validate

    return if first_move.valid? && second_move.valid?
    move.errors[:base] << 'That jump is not legal.'
  end
end
