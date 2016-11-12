class WallValidator < AbstractMoveValidator
  include WallHelpers

  def validate
    validate_does_not_overlap_with_existing_wall
    validate_does_not_cross_existing_wall
    validate_wall_does_not_extend_off_board
  end

  private

  def validate_does_not_overlap_with_existing_wall
    return unless overlapping_walls.present?
    move.errors[:base] << 'That wall would overlap with another one.'
  end

  def validate_does_not_cross_existing_wall
    return if move.horizontal_wall? && !horizontal_wall_crosses_another_wall?
    return if move.vertical_wall? && !vertical_wall_crosses_another_wall?
    move.errors[:base] << 'That wall would cross another one.'
  end

  def validate_wall_does_not_extend_off_board
    return if move.horizontal_wall? && horizontal_wall_in_bounds?
    return if move.vertical_wall? && vertical_wall_in_bounds?
    move.errors[:base] << 'That wall would extend off of the board.'
  end
end
