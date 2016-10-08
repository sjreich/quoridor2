require 'rails_helper'

describe 'TranslationValidator' do
  let(:game) { create :game }

  let(:new_move) do
    game.moves.create(player: 1, variety: :translation, **move_direction)
  end
  subject { new_move.errors.messages[:base] }

  describe 'a move cannot land in an occupied square' do
    include_context('player location', player: 1, x: 5, y: 5)

    context 'opponent is just left of player' do
      include_context('player location', player: 2, x: 4, y: 5)
      include_examples 'when going', [:left], :occupied
    end

    context 'opponent is just above player' do
      include_context('player location', player: 2, x: 5, y: 4)
      include_examples 'when going', [:up], :occupied
    end

    context 'opponent is just right of player' do
      include_context('player location', player: 2, x: 6, y: 5)
      include_examples 'when going', [:right], :occupied
    end

    context 'opponent is just below player' do
      include_context('player location', player: 2, x: 5, y: 6)
      include_examples 'when going', [:down], :occupied
    end

    context 'opponent is two spaces left of player' do
      include_context('player location', player: 2, x: 3, y: 5)
      include_examples 'when going', [:two_left], :occupied
    end

    context 'opponent is two spaces above player' do
      include_context('player location', player: 2, x: 5, y: 3)
      include_examples 'when going', [:two_up], :occupied
    end

    context 'opponent is two spaces right of player' do
      include_context('player location', player: 2, x: 7, y: 5)
      include_examples 'when going', [:two_right], :occupied
    end

    context 'opponent is two spaces below player' do
      include_context('player location', player: 2, x: 5, y: 7)
      include_examples 'when going', [:two_down], :occupied
    end
  end

  describe 'a move cannot leave the board' do
    context 'player is on the left edge' do
      include_context('player location', player: 1, x: 1, y: rand(1..9))
      include_examples 'when going', [:left, :two_left], :out_of_bounds
    end

    context 'player is on the top' do
      include_context('player location', player: 1, x: rand(1..9), y: 1)
      include_examples 'when going', [:up, :two_up], :out_of_bounds
    end

    context 'player is on the right edge' do
      include_context('player location', player: 1, x: 9, y: rand(1..9))
      include_examples 'when going', [:right, :two_right], :out_of_bounds
    end

    context 'player is on the bottom' do
      include_context('player location', player: 1, x: rand(1..9), y: 9)
      include_examples 'when going', [:down, :two_down], :out_of_bounds
    end

    context 'player is one away from the left edge' do
      include_context('player location', player: 1, x: 2, y: rand(1..9))
      include_examples 'when going', [:two_left], :out_of_bounds
    end

    context 'player is one away from the top' do
      include_context('player location', player: 1, x: rand(1..9), y: 2)
      include_examples 'when going', [:two_up], :out_of_bounds
    end

    context 'player is one away from the right edge' do
      include_context('player location', player: 1, x: 8, y: rand(1..9))
      include_examples 'when going', [:two_right], :out_of_bounds
    end

    context 'player is one away from the bottom' do
      include_context('player location', player: 1, x: rand(1..9), y: 8)
      include_examples 'when going', [:two_down], :out_of_bounds
    end
  end

  describe 'a translation cannot cross a wall' do
    include_context('player location', player: 1, x: 5, y: 5)

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
