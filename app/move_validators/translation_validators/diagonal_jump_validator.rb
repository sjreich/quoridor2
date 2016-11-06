class DiagonalJumpValidator < AbstractMoveValidator
  include TranslationHelpers

  def validate
    return if diagonal_works?(:x, :y)
    return if diagonal_works?(:y, :x)

    move.errors[:base] << 'That jump is not legal.'
  end

  private

  def diagonal_works?(first_dir, second_dir)
    raise 'Illegal Directions' unless [:x, :y] == [first_dir, second_dir].sort

    move_onto_opponent = first_pseudo_move(first_dir)
    return false unless move_onto_opponent.valid?

    intermediate_state = pseudo_game_update(move_onto_opponent)

    continue_straight = second_pseudo_move(first_dir, intermediate_state)
    return false if continue_straight.valid?

    turn_the_corner = second_pseudo_move(second_dir, intermediate_state)
    turn_the_corner.valid?
  end

  def first_pseudo_move(direction)
    PseudoMove.new(pseudo_move_params(direction)).tap do |move|
      PseudoTranslationValidator.new(move, prior_game_state).validate
    end
  end

  def second_pseudo_move(direction, intermediate_state)
    PseudoMove.new(pseudo_move_params(direction)).tap do |move|
      SimpleTranslationValidator.new(move, intermediate_state).validate
    end
  end

  def pseudo_move_params(direction)
    {
      x: direction == :x ? move.x : 0,
      y: direction == :y ? move.y : 0,
      variety: :translation,
      player: move.player,
    }
  end
end
