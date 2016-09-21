require 'rails_helper'

describe 'Player' do
  let(:player) { Player.new(number, moves) }
  let(:game) { create :game }

  describe 'calculates player position' do
    subject { player.position }

    let(:x_change) { 0 }
    let(:y_change) { 0 }
    let(:moves) { [move] }
    let(:move) do
      Move.new(game: game,
               variety: :translation,
               player: number,
               x: x_change,
               y: y_change)
    end

    context 'when player1 moves' do
      let(:number) { 1 }

      context 'left' do
        let(:x_change) { -1 }
        it { should eq(x: 4, y: 1) }
      end

      context 'right' do
        let(:x_change) { 1 }
        it { should eq(x: 6, y: 1) }
      end

      context 'down' do
        let(:y_change) { 1 }
        it { should eq(x: 5, y: 2) }
      end

      context 'up' do
        let(:y_change) { -1 }
        it { should eq(x: 5, y: 0) }
      end
    end
  end

  describe 'calculates walls remaining' do
    subject { player.walls_remaining }
    let(:number) { rand(1..4) }
    let(:number_of_moves) { rand(2..8) }
    let(:moves) do
      [].tap do |moves|
        number_of_moves.times do |i|
          moves << Move.new(game: game,
                            variety: variety,
                            player: number,
                            x: i + 2,
                            y: i + 2)
        end
      end
    end

    context 'at game start' do
      let(:number_of_moves) { 0 }
      it { should eq Game::STARTING_WALL_COUNT }
    end

    context 'after horizontal walls played' do
      let(:variety) { :horizontal_wall }
      it { should eq Game::STARTING_WALL_COUNT - number_of_moves }
    end

    context 'after horizontal walls played' do
      let(:variety) { :vertical_wall }
      it { should eq Game::STARTING_WALL_COUNT - number_of_moves }
    end
  end
end
