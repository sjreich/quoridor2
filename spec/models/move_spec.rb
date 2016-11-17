require 'rails_helper'

RSpec.describe Move, type: :model do
  let(:game) { create :game }

  describe 'ordinal attribute auto-increments' do
    subject { create(:move, game: game).reload.ordinal }

    context 'when this is the first move of the game' do
      it { should eq 1 }
    end

    context 'when the game has previously existing moves' do
      let(:previous_move_count) { rand(2..7) }
      before do
        previous_move_count.times { create(:move, game: game) }
      end

      it { should eq previous_move_count + 1 }
    end
  end

  describe 'ordinal is unique within the game' do
    subject { new_move.save }

    let(:new_move) { build :move, game: game, ordinal: new_ordinal }

    context 'when CURRENT game has a 23rd move' do
      before { create :move, game: game, ordinal: 23 }

      context 'when new ordinal is 23' do
        let(:new_ordinal) { 23 }
        it { should be false }
      end

      context 'when new ordinal is 24' do
        let(:new_ordinal) { 24 }
        it { should be true }
      end
    end

    context 'when DIFFERENT game has a 23rd move' do
      let(:other_game) { create :game }
      before { create :move, game: other_game, ordinal: 23 }

      context 'when new ordinal is 23' do
        let(:new_ordinal) { 23 }
        it { should be true }
      end
    end
  end

  describe '#save' do
    context 'move fails custom validations' do
      subject do
        Move.new(
          game: game,
          player: 1,
          variety: :translation,
          x: 1000,
          y: 1000
        )
      end

      its(:save) { should be false }
    end
  end
end
