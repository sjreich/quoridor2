module TranslationHelpers
  def validate_lands_on_opponent
    return if current_player_positions.include? position_after(move)
    move.errors[:base] << 'This square is already occupied.'
  end

  def validate_stays_on_the_board
    return unless position_after(move).values.any? { |i| i < 1 || i > 9 }
    move.errors[:base] << 'This move would place the piece off of the board.'
  end

  def validate_does_not_cross_wall
    return unless (actual_walls & crossed_walls).present?
    move.errors[:base] << 'This move would cross through a wall.'
  end

  def validate_does_not_land_on_opponent
    return unless current_player_positions.include? position_after(move)
    move.errors[:base] << 'This square is already occupied.'
  end

  def position_before
    current_player_info[:position]
  end

  def position_after(new_move)
    move_coords = new_move.to_coords.symbolize_keys
    position_before.merge(move_coords) do |_x_or_y, position, change|
      position + change
    end
  end

  def actual_walls
    return prior_game_state[:walls][:horizontal] if move.x.zero?
    return prior_game_state[:walls][:vertical] if move.y.zero?
  end

  def crossed_walls
    position = position_before

    relative_xs = RELATIVE_LOCATIONS_CROSSED[move.x] || []
    relative_ys = RELATIVE_LOCATIONS_CROSSED[move.y] || []

    rel_xy_combos = relative_xs.product(relative_ys)

    rel_xy_combos.map do |relative_x, relative_y|
      {
        x: position[:x] + relative_x,
        y: position[:y] + relative_y,
      }
    end
  end

  def pseudo_game_update(pseudo_move)
    game_state = Marshal.load(Marshal.dump(prior_game_state))
    game_state.tap do |game|
      position = player_position(game, move.player)
      position[:x] += pseudo_move.x
      position[:y] += pseudo_move.y
    end
  end

  def player_position(game_state, number)
    game_state[:players].find { |p| p[:number] == number }[:position]
  end

  RELATIVE_LOCATIONS_CROSSED = {
    -1 => [0],
    0 => [0, -1],
    1 => [1],
  }.freeze
end
