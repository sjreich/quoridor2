require 'rails_helper'

RSpec.describe Move, type: :model do
  describe 'ordinal attribute auto-increments' do
    subject { m = Move.create(game: game, variety: :translation, player: 1, x: 1, y: 1).reload.ordinal }
    let(:game) { create :game }

    context 'when this is the first move of the game' do
      it { should eq 1 }
    end

    context 'when the game has previously existing moves' do
      let(:previous_move_count) { rand(2..7) }
      before do
        previous_move_count.times { Move.create(game: game, variety: :translation, player: 1, x: 1, y: 1) }
      end

      it { should eq previous_move_count + 1 }
    end
  end

  describe 'ordinal is unique within the game' do
    subject { new_move.save }

    let(:new_move) { Move.new(game: current_game, ordinal: new_ordinal, variety: :translation, player: 1, x: 1, y: 1) }
    let!(:current_game) { create :game }
    let(:other_game) { create :game }

    context 'when CURRENT game has a 23rd move' do
      before { Move.create(game: current_game, ordinal: 23, variety: :translation, player: 1, x: 1, y: 1) }

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
      before { Move.create(game: other_game, ordinal: 23) }

      context 'when new ordinal is 23' do
        let(:new_ordinal) { 23 }
        it { should be true }
      end
    end
  end
end
