require 'rails_helper'

describe StraightJumpValidator do
  include_context('basic setup for translation validation')
  include_context('player location', player: 1, x: 5, y: 5)

  context 'opponent is just left of player' do
    include_context('player location', player: 2, x: 4, y: 5)
    include_examples 'when going', :two_left, :no_error
  end

  context 'opponent is just below player' do
    include_context('player location', player: 2, x: 5, y: 6)
    include_examples 'when going', :two_down, :no_error
  end

  context 'opponent is not nearby' do
    include_examples 'when going', :two_left, :illegal_jump
    include_examples 'when going', :two_down, :illegal_jump
  end
end
