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
  up_left:    { x: -1, y: -1 },
  up_right:   { x:  1, y: -1 },
  down_right: { x:  1, y:  1 },
  down_left:  { x: -1, y:  1 },
}.freeze

ERROR_TYPES = {
  wildly_illegal: ['No way.'],
  occupied: ['This square is already occupied.'],
  crosses_a_wall: ['This move would cross through a wall.'],
  out_of_bounds: ['This move would place the piece off of the board.'],
  illegal_jump: ['That jump is not legal.'],
  overlapping_wall: ['That wall would overlap with another one.'],
  crossing_wall: ['That wall would cross another one.'],
  wall_out_of_bounds: ['That wall would extend off of the board.'],
  no_error: [],
}.freeze

shared_examples 'when going' do |dir, error|
  context "when moving #{dir}" do
    let(:move_direction) { DIRECTIONS[dir] }
    it { should eq ERROR_TYPES[error] }
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

shared_context 'basic setup for translation validation' do
  let(:game) { create :game }

  let(:new_move) do
    game.moves.create(player: 1, variety: :translation, **move_direction)
  end

  subject { new_move.errors.messages[:base] }
end

shared_context 'basic setup for wall validation' do
  let(:game) { create :game }

  let(:new_move) do
    game.moves.create(player: 1, variety: variety, **location)
  end

  subject { new_move.errors.messages[:base] }
end
