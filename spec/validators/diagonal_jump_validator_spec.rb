require 'rails_helper'

describe DiagonalJumpValidator do
  include_context('basic setup for translation validation')
  include_context('player location', player: 1, x: 5, y: 5)

  context 'diagonal jumps' do
    context 'opponent is just left of player' do
      include_context('player location', player: 2, x: 4, y: 5)

      context 'when wall does not block straight jump' do
        include_examples 'when going', :up_left, :illegal_jump
        include_examples 'when going', :down_left, :illegal_jump
      end

      context 'when wall blocks straight jump' do
        include_context('walls present at', vertical: [{ x: 4, y: 5 }])
        include_examples 'when going', :up_left, :no_error
        include_examples 'when going', :down_left, :no_error
      end
    end

    context 'opponent is just above player' do
      include_context('player location', player: 2, x: 5, y: 4)

      context 'when wall does not block straight jump' do
        include_examples 'when going', :up_left, :illegal_jump
        include_examples 'when going', :up_right, :illegal_jump
      end

      context 'when wall blocks straight jump' do
        include_context('walls present at', horizontal: [{ x: 5, y: 4 }])
        include_examples 'when going', :up_left, :no_error
        include_examples 'when going', :up_right, :no_error
      end
    end
  end
end
