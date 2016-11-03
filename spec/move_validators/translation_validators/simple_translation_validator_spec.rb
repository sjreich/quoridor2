require 'rails_helper'

describe SimpleTranslationValidator do
  include_context('basic setup for translation validation')

  describe 'a move cannot land in an occupied square' do
    include_context('player location', player: 1, x: 5, y: 5)

    context 'opponent is left of player' do
      include_context('player location', player: 2, x: 4, y: 5)
      include_examples 'when going', :left, :occupied
      include_examples 'when going', :right, :no_error
    end

    context 'opponent is below player' do
      include_context('player location', player: 2, x: 5, y: 6)
      include_examples 'when going', :down, :occupied
      include_examples 'when going', :up, :no_error
    end
  end

  describe 'a move cannot leave the board' do
    context 'player is on the left edge' do
      include_context('player location', player: 1, x: 1, y: rand(1..9))
      include_examples 'when going', :left, :out_of_bounds
      include_examples 'when going', :right, :no_error
    end

    context 'player is on the top' do
      include_context('player location', player: 1, x: rand(1..9), y: 1)
      include_examples 'when going', :up, :out_of_bounds
      include_examples 'when going', :down, :no_error
    end

    context 'player is on the right edge' do
      include_context('player location', player: 1, x: 9, y: rand(1..9))
      include_examples 'when going', :right, :out_of_bounds
      include_examples 'when going', :left, :no_error
    end

    context 'player is on the bottom' do
      include_context('player location', player: 1, x: rand(1..9), y: 9)
      include_examples 'when going', :down, :out_of_bounds
      include_examples 'when going', :up, :no_error
    end
  end

  describe 'a translation cannot cross a wall' do
    include_context('player location', player: 1, x: 5, y: 5)

    context 'vertical wall is on right of piece and up' do
      include_context('walls present at', vertical: [{ x: 6, y: 4 }])
      include_examples 'when going', :right, :crosses_a_wall
      include_examples 'when going', :left, :no_error
    end

    context 'vertical wall is on right of piece and down' do
      include_context('walls present at', vertical: [{ x: 6, y: 5 }])
      include_examples 'when going', :right, :crosses_a_wall
      include_examples 'when going', :left, :no_error
    end

    context 'horizontal wall above piece and left' do
      include_context('walls present at', horizontal: [{ x: 4, y: 5 }])
      include_examples 'when going', :up, :crosses_a_wall
      include_examples 'when going', :down, :no_error
    end

    context 'horizontal wall above piece and right' do
      include_context('walls present at', horizontal: [{ x: 5, y: 5 }])
      include_examples 'when going', :up, :crosses_a_wall
      include_examples 'when going', :down, :no_error
    end
  end
end
