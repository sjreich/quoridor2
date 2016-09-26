class TranslationValidator < ActiveModel::Validator
  def validate(move)
    validate_does_not_cross_wall(move)
  end

  private

  def validate_does_not_cross_wall(move)
    return unless (actual_walls(move) & crossed_walls(move)).present?
    move.errors[:base] << 'This move would cross through a wall.'
  end

  def players(move)
    move.game.state[:players]
  end

  def current_player_info(move)
    players(move).find { |player| player[:number] == move[:player] }
  end

  def position_before(move)
    current_player_info(move)[:position]
  end

  def actual_walls(move)
    return move.game.horizontal_walls if move.x.zero?
    return move.game.vertical_walls if move.y.zero?
  end

  def crossed_walls(move)
    position = position_before(move)

    relative_xs = RELATIVE_LOCATIONS_CROSSED[move.x]
    relative_ys = RELATIVE_LOCATIONS_CROSSED[move.y]

    rel_xy_combos = relative_xs.product(relative_ys)

    rel_xy_combos.map do |relative_x, relative_y|
      {
        x: position[:x] + relative_x,
        y: position[:y] + relative_y,
      }
    end
  end

  RELATIVE_LOCATIONS_CROSSED = {
    -2 => [0, -1],
    -1 => [0],
    0 => [0, -1],
    1 => [1],
    2 => [1, 2],
  }.freeze
end
