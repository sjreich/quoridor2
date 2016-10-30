class AATranslationValidator
  include ActualTranslationValidationMethods

  def validate
    validate_not_wildly_illegal
    if move.simple_translation?
      validate_does_not_land_on_opponent
      validate_stays_on_the_board
      validate_does_not_cross_wall
    elsif move.straight_jump?
      validate_straight_jump
    elsif move.diagonal_jump?
      validate_diagonal_jump
    end
  end

  private

  def validate_straight_jump
    first_move = FirstPseudoMove.new(x: move.x / 2, y: move.y / 2, variety: :translation, game: move.game, player: move.player)
    first_move.validate
    move.game.moves.build(first_move.attributes)
    second_move = SecondPseudoMove.new(x: move.x / 2, y: move.y / 2, variety: :translation, game: move.game, player: move.player)
    second_move.validate
    return if first_move.errors.empty? && second_move.errors.empty?
    move.errors[:base] << 'That jump is not legal.'
  end

  def validate_diagonal_jump
    first_move_a = FirstPseudoMove.new(x: move.x, y: 0, game: move.game, variety: :translation, player: move.player)
    first_move_a.validate
    move.game.moves.build(first_move_a.attributes)
    second_move_a = SecondPseudoMove.new(x: 0, y: move.y, game: move.game, variety: :translation, player: move.player)
    second_move_a.validate
    return if first_move_a.errors.empty? && second_move_a.errors.empty?

    first_move_b = FirstPseudoMove.new(x: move.x, y: 0, game: move.game, variety: :translation, player: move.player)
    first_move_b.validate
    move.game.reload.moves.build(first_move_b.attributes)
    second_move_b = SecondPseudoMove.new(x: 0, y: move.y, game: move.game, variety: :translation, player: move.player)
    second_move_b.validate
    return if first_move_b.errors.empty? && second_move_b.errors.empty?

    move.errors[:base] << 'That jump is not legal.'
  end
end
