require 'rails_helper'

describe 'TranslationValidator' do
  include_context('basic setup for translation validation')

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
end
