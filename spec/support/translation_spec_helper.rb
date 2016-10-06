require 'rails_helper'

DIRECTIONS = {
  left:       { x: -1, y:  0 },
  right:      { x:  1, y:  0 },
  up:         { x:  0, y: -1 },
  down:       { x:  0, y:  1 },

  two_left:   { x: -2, y:  0 },
  two_right:  { x:  2, y:  0 },
  two_up:     { x:  0, y: -2 },
  two_down:   { x:  0, y:  2 },
}.freeze

ERROR_TYPES = {
  occupied: { base: ['This square is already occupied.'] },
  crosses_a_wall: { base: ['This move would cross through a wall.'] },
  out_of_bounds: { base: ['This move would place the piece off of the board.'] }
}.freeze

shared_examples 'when going' do |illegal_dirs, error|
  DIRECTIONS.each do |dir, deltas|
    next unless illegal_dirs.include? dir

    context "when moving #{dir}" do
      let(:move_direction) { deltas }
      it { should eq ERROR_TYPES[error] }
    end
  end
end

shared_context 'player location' do |situation|
  starting = Game::STARTING_LOCATIONS[situation[:player]]

  x_difference = situation[:x] - starting[:x]
  x = x_difference.positive? ? 1 : -1

  y_difference = situation[:y] - starting[:y]
  y = y_difference.positive? ? 1 : -1

  before do
    x_difference.abs.times do
      move = game.moves.build(player: situation[:player],
                              variety: :translation,
                              x: x,
                              y: 0)
      move.save(validate: false)
    end

    y_difference.abs.times do
      move = game.moves.build(player: situation[:player],
                              variety: :translation,
                              x: 0,
                              y: y)
      move.save(validate: false)
    end
  end
end

shared_context 'walls present at' do |walls|
  horizontal_walls = walls[:horizontal] || []
  vertical_walls = walls[:vertical] || []

  before do
    horizontal_walls.each do |wall|
      move = game.moves.build(player: 1, variety: :horizontal_wall, **wall)
      move.save(validate: false)
    end

    vertical_walls.each do |wall|
      move = game.moves.build(player: 1, variety: :vertical_wall, **wall)
      move.save(validate: false)
    end
  end
end
