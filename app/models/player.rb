class Player
  attr_reader :moves, :number

  def initialize(number, moves)
    @number = number
    @moves = moves
  end

  def position
    translations.each_with_object(starting_position) do |move, position|
      position[:x] += move.x
      position[:y] += move.y
    end
  end

  def walls_remaining
    Game::STARTING_WALL_COUNT - walls.count
  end

  private

  def walls
    moves.select(&:wall?)
  end

  def translations
    moves.select(&:translation?)
  end

  def starting_position
    Game::STARTING_LOCATIONS[number].dup
  end
end
