require 'rails_helper'

describe 'TranslationValidator' do
  let(:game) { create :game }

  let(:new_move) do
    game.moves.create(player: 1, variety: :translation, **move_direction)
  end
  subject { new_move.errors.messages[:base] }

  describe 'wildly illegal moves' do
    include_context('player location', player: 1, x: 5, y: 5)

    context 'nowhere' do
      let(:move_direction) { { x: 0, y: 0 } }
      it { should eq ERROR_TYPES[:wildly_illegal] }
    end

    context 'three left' do
      let(:move_direction) { { x: -3, y: 0 } }
      it { should eq ERROR_TYPES[:wildly_illegal] }
    end

    context 'two down, one right' do
      let(:move_direction) { { x: 1, y: 2 } }
      it { should eq ERROR_TYPES[:wildly_illegal] }
    end
  end

  describe 'jumping opponent' do
    include_context('player location', player: 1, x: 5, y: 5)

    context 'straight jumps' do
      context 'opponent is just left of player' do
        include_context('player location', player: 2, x: 4, y: 5)
        include_examples 'when going', :two_left, :no_error
      end

      context 'opponent is just below player' do
        include_context('player location', player: 2, x: 5, y: 6)
        include_examples 'when going', :two_down, :no_error
      end
    end

    context 'diagonal jumps' do
      context 'opponent is just left of player' do
        include_context('player location', player: 2, x: 4, y: 5)

        context 'when wall does not block straight jump' do
          include_examples 'when going', :up_left, :illegal_jump
          include_examples 'when going', :down_left, :illegal_jump
        end

        context 'when wall blocks straight jump' do
          include_context('walls present at', vertical: [{ x: 5, y: 5 }])
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
          include_context('walls present at', horizontal: [{ x: 5, y: 5 }])
          include_examples 'when going', :up_left, :no_error
          include_examples 'when going', :up_right, :no_error
        end
      end
    end
  end
end
