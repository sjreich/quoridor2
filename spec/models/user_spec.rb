require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe '#games' do
    subject { user.games }

    let(:opponent) { create :user }
    let(:player1) { opponent }
    let(:player2) { opponent }
    let(:game) do
      Game.create(player1: player1,
                  player2: player2,
                  player3: player3,
                  player4: player4)
    end

    context 'when the game has two players' do
      let(:player3) { nil }
      let(:player4) { nil }

      context 'and the user is not playing' do
        it 'should NOT include the game' do
          expect(subject).not_to include game
        end
      end

      (1..2).each do |number|
        context "and the user is player#{number}" do
          let("player#{number}".to_sym) { user }
          it 'SHOULD include the game' do
            expect(subject).to include game
          end
        end
      end
    end

    context 'when the game has four players' do
      let(:player3) { opponent }
      let(:player4) { opponent }

      context 'and the user is not playing' do
        it 'should NOT include the game' do
          expect(subject).not_to include game
        end
      end

      (1..4).each do |number|
        context "and the user is player#{number}" do
          let("player#{number}".to_sym) { user }
          it 'SHOULD include the game' do
            expect(subject).to include game
          end
        end
      end
    end
  end
end
