module WallHelpers
  def walls_on_same_row
    horizontal_walls.select { |w| w[:y] == move.y }
  end

  def walls_on_same_column
    vertical_walls.select { |w| w[:x] == move.x }
  end

  def walls_within_one_column
    horizontal_walls.select { |w| (w[:x] - move.x).abs <= 1 }
  end

  def walls_within_one_row
    vertical_walls.select { |w| (w[:y] - move.y).abs <= 1 }
  end

  def horizontal_wall_in_bounds?
    (1..7).cover?(move.x) && (2..8).cover?(move.y)
  end

  def vertical_wall_in_bounds?
    (2..8).cover?(move.x) && (1..7).cover?(move.y)
  end

  def horizontal_wall_crosses_another_wall?
    crossing_wall = { x: move.x + 1, y: move.y - 1 }
    vertical_walls.include? crossing_wall
  end

  def vertical_wall_crosses_another_wall?
    crossing_wall = { x: move.x - 1, y: move.y + 1 }
    horizontal_walls.include? crossing_wall
  end

  def overlapping_walls
    if move.horizontal_wall?
      walls_on_same_row & walls_within_one_column
    else
      walls_on_same_column & walls_within_one_row
    end
  end

  def horizontal_walls
    move.game.horizontal_walls
  end

  def vertical_walls
    move.game.vertical_walls
  end
end
