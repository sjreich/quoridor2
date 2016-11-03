class DiagonalJumpValidator < AbstractMoveValidator
  include TranslationHelpers

  def validate
    return if horizontal_first_works?
    return if vertical_first_works?

    move.errors[:base] << 'That jump is not legal.'
  end

  private

  def horizontal_first_works?
    first_move_a = PseudoMove.new(x: move.x, y: 0, variety: :translation, player: move.player)
    PseudoTranslationValidator.new(first_move_a, prior_game_state).validate
    intermediate_game_state = Marshal.load(Marshal.dump(prior_game_state))
    intermediate_game_state[:players].find { |p| p[:number] == move.player }[:position][:x] += first_move_a.x
    intermediate_game_state[:players].find { |p| p[:number] == move.player }[:position][:y] += first_move_a.y

    second_move_a1 = PseudoMove.new(x: move.x, y: 0, variety: :translation, player: move.player)
    SimpleTranslationValidator.new(second_move_a1, intermediate_game_state).validate

    second_move_a2 = PseudoMove.new(x: 0, y: move.y, variety: :translation, player: move.player)
    SimpleTranslationValidator.new(second_move_a2, intermediate_game_state).validate

    first_move_a.valid? && !second_move_a1.valid? && second_move_a2.valid?
  end

  def vertical_first_works?
    first_move_b = PseudoMove.new(x: 0, y: move.y, variety: :translation, player: move.player)
    PseudoTranslationValidator.new(first_move_b, prior_game_state).validate
    intermediate_game_state = Marshal.load(Marshal.dump(prior_game_state))
    intermediate_game_state[:players].find { |p| p[:number] == move.player }[:position][:x] += first_move_b.x
    intermediate_game_state[:players].find { |p| p[:number] == move.player }[:position][:y] += first_move_b.y

    second_move_b1 = PseudoMove.new(x: 0, y: move.y, variety: :translation, player: move.player)
    SimpleTranslationValidator.new(second_move_b1, intermediate_game_state).validate

    second_move_b2 = PseudoMove.new(x: move.x, y: 0, variety: :translation, player: move.player)
    SimpleTranslationValidator.new(second_move_b2, intermediate_game_state).validate

    first_move_b.valid? && !second_move_b1.valid? && second_move_b2.valid?
  end
end
