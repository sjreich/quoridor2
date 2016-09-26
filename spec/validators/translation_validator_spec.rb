require 'rails_helper'

describe 'TranslationValidator' do
  let(:game) { create :game }

  describe 'a translation cannot cross a wall' do
    include_context('player location', player: 1, x: 5, y: 5)

    let(:new_move) do
      game.moves.create(player: 1, variety: :translation, **move_direction)
    end
    subject { new_move.errors.messages }

    context 'vertical wall' do
      context 'wall is just on the left of the piece and up' do
        include_context('walls present at', vertical: [{ x: 5, y: 4 }])
        include_examples 'when going', [:left, :two_left], :crosses_a_wall
      end

      context 'wall is just on the left of the piece and down' do
        include_context('walls present at', vertical: [{ x: 5, y: 5 }])
        include_examples 'when going', [:left, :two_left], :crosses_a_wall
      end

      context 'wall is just on the right of the piece and up' do
        include_context('walls present at', vertical: [{ x: 6, y: 4 }])
        include_examples 'when going', [:right, :two_right], :crosses_a_wall
      end

      context 'wall is just on the right of the piece and down' do
        include_context('walls present at', vertical: [{ x: 6, y: 5 }])
        include_examples 'when going', [:right, :two_right], :crosses_a_wall
      end

      context 'wall is one away on the left of the piece and up' do
        include_context('walls present at', vertical: [{ x: 4, y: 4 }])
        include_examples 'when going', [:two_left], :crosses_a_wall
      end

      context 'wall is one away on the left of the piece and down' do
        include_context('walls present at', vertical: [{ x: 4, y: 5 }])
        include_examples 'when going', [:two_left], :crosses_a_wall
      end

      context 'wall is one away on the right of the piece and up' do
        include_context('walls present at', vertical: [{ x: 7, y: 4 }])
        include_examples 'when going', [:two_right], :crosses_a_wall
      end

      context 'wall is one away on the right of the piece and down' do
        include_context('walls present at', vertical: [{ x: 7, y: 5 }])
        include_examples 'when going', [:two_right], :crosses_a_wall
      end
    end

    context 'horizontal wall' do
      context 'wall is just above of the piece and left' do
        include_context('walls present at', horizontal: [{ x: 4, y: 5 }])
        include_examples 'when going', [:up, :two_up], :crosses_a_wall
      end

      context 'wall is just above of the piece and right' do
        include_context('walls present at', horizontal: [{ x: 5, y: 5 }])
        include_examples 'when going', [:up, :two_up], :crosses_a_wall
      end

      context 'wall is just below of the piece and left' do
        include_context('walls present at', horizontal: [{ x: 4, y: 6 }])
        include_examples 'when going', [:down, :two_down], :crosses_a_wall
      end

      context 'wall is just below of the piece and right' do
        include_context('walls present at', horizontal: [{ x: 5, y: 6 }])
        include_examples 'when going', [:down, :two_down], :crosses_a_wall
      end

      context 'wall is one away above of the piece and left' do
        include_context('walls present at', horizontal: [{ x: 4, y: 4 }])
        include_examples 'when going', [:two_up], :crosses_a_wall
      end

      context 'wall is one away above of the piece and right' do
        include_context('walls present at', horizontal: [{ x: 5, y: 4 }])
        include_examples 'when going', [:two_up], :crosses_a_wall
      end

      context 'wall is one away below of the piece and left' do
        include_context('walls present at', horizontal: [{ x: 4, y: 7 }])
        include_examples 'when going', [:two_down], :crosses_a_wall
      end

      context 'wall is one away below of the piece and right' do
        include_context('walls present at', horizontal: [{ x: 5, y: 7 }])
        include_examples 'when going', [:two_down], :crosses_a_wall
      end
    end
  end
end
