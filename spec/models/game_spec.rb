require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { create :game }

  describe 'wall_coordinates' do
    let(:expected_coordinates) do
      [{ x: 2, y: 2 },
       { x: 4, y: 4 },
       { x: 6, y: 6 },]
    end

    before do
      [1, 2, 3].each do |i|
        Move.create(game: game,
                    variety: variety,
                    player: i,
                    x: i * 2,
                    y: i * 2)
      end
    end

    context 'horizontal walls' do
      subject { game.reload.horizontal_walls }
      let(:variety) { :horizontal_wall }
      it { should eq expected_coordinates }
    end

    context 'vertical walls' do
      subject { game.reload.vertical_walls }
      let(:variety) { :vertical_wall }
      it { should eq expected_coordinates }
    end
  end
end
