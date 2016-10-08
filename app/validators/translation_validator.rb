class TranslationValidator < ActiveModel::Validator
  def validate(move)
    validate_not_wildly_illegal(move)
    validate_stays_on_the_board(move)
    validate_does_not_cross_wall(move)
    validate_does_not_land_on_opponent(move)
  end

  private

  def validate_not_wildly_illegal(move)
    one_space_or_jump?(move)
    move.errors[:base] << 'No way.'
  end

  def validate_does_not_land_on_opponent(move)
    return unless current_player_positions(move).include? position_after(move)
    move.errors[:base] << 'This square is already occupied.'
  end

  def validate_stays_on_the_board(move)
    return unless position_after(move).values.any? { |i| i < 1 || i > 9 }
    move.errors[:base] << 'This move would place the piece off of the board.'
  end

  def validate_does_not_cross_wall(move)
    return unless (actual_walls(move) & crossed_walls(move)).present?
    move.errors[:base] << 'This move would cross through a wall.'
  end

  def players(move)
    move.game.state[:players]
  end

  def current_player_positions(move)
    players(move).map do |player|
      player[:position]
    end
  end

  def current_player_info(move)
    players(move).find { |player| player[:number] == move[:player] }
  end

  def position_before(move)
    current_player_info(move)[:position]
  end

  def position_after(move)
    move_coords = move.slice(:x, :y).symbolize_keys
    position_before(move).merge(move_coords) do |_x_or_y, position, change|
      position + change
    end
  end

  def actual_walls(move)
    return move.game.horizontal_walls if move.x.zero?
    return move.game.vertical_walls if move.y.zero?
  end

  def crossed_walls(move)
    position = position_before(move)

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

  def one_space_or_jump?(move)
    values = move.slice(:x, :y).symbolize_keys.values.map(&:abs).sort
    [[1, 1], [0, 2]].include? values
  end

  RELATIVE_LOCATIONS_CROSSED = {
    -2 => [0, -1],
    -1 => [0],
    0 => [0, -1],
    1 => [1],
    2 => [1, 2],
  }.freeze
end
