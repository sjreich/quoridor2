class StraightJumpValidator < AbstractMoveValidator
  include TranslationHelpers

  def validate
    return if straight_jump_works?
    move.errors[:base] << 'That jump is not legal.'
  end

  private

  def straight_jump_works?
    move_onto_opponent = first_pseudo_move
    return false unless move_onto_opponent.valid?

    intermediate_state = pseudo_game_update(move_onto_opponent)

    continue_straight = second_pseudo_move(intermediate_state)
    continue_straight.valid?
  end

  def first_pseudo_move
    PseudoMove.new(pseudo_move_params).tap do |move|
      PseudoTranslationValidator.new(move, prior_game_state).validate
    end
  end

  def second_pseudo_move(intermediate_state)
    PseudoMove.new(pseudo_move_params).tap do |move|
      SimpleTranslationValidator.new(move, intermediate_state).validate
    end
  end

  def pseudo_move_params
    {
      x: move.x / 2,
      y: move.y / 2,
      variety: :translation,
      player: move.player,
    }
  end
end
