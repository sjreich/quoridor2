require 'rails_helper'

describe 'Basic Wall Validation' do
  include_context('basic setup for wall validation')

  describe 'a wall overlap with another wall' do
    context 'horizontal walls' do
      let(:variety) { :horizontal_wall }
      include_context('walls present at', horizontal: [{ x: 5, y: 5 }])

      context 'full overlap' do
        let(:location) { { x: 5, y: 5 } }
        it { should eq ERROR_TYPES[:overlapping_wall] }
      end

      context 'overlap on first end' do
        let(:location) { { x: 4, y: 5 } }
        it { should eq ERROR_TYPES[:overlapping_wall] }
      end

      context 'overlap on second end' do
        let(:location) { { x: 6, y: 5 } }
        it { should eq ERROR_TYPES[:overlapping_wall] }
      end

      context 'two before on the same row' do
        let(:location) { { x: 3, y: 5 } }
        it { should eq ERROR_TYPES[:no_error] }
      end

      context 'two after on the same row' do
        let(:location) { { x: 7, y: 5 } }
        it { should eq ERROR_TYPES[:no_error] }
      end

      context 'previous row' do
        let(:location) { { x: 5, y: 4 } }
        it { should eq ERROR_TYPES[:no_error] }
      end

      context 'next row' do
        let(:location) { { x: 5, y: 6 } }
        it { should eq ERROR_TYPES[:no_error] }
      end
    end

    context 'vertical walls' do
      let(:variety) { :vertical_wall }
      include_context('walls present at', vertical: [{ x: 5, y: 5 }])

      context 'full overlap' do
        let(:location) { { x: 5, y: 5 } }
        it { should eq ERROR_TYPES[:overlapping_wall] }
      end

      context 'overlap on first end' do
        let(:location) { { x: 5, y: 4 } }
        it { should eq ERROR_TYPES[:overlapping_wall] }
      end

      context 'overlap on second end' do
        let(:location) { { x: 5, y: 6 } }
        it { should eq ERROR_TYPES[:overlapping_wall] }
      end

      context 'two before on the same row' do
        let(:location) { { x: 5, y: 3 } }
        it { should eq ERROR_TYPES[:no_error] }
      end

      context 'two after on the same row' do
        let(:location) { { x: 5, y: 7 } }
        it { should eq ERROR_TYPES[:no_error] }
      end

      context 'previous row' do
        let(:location) { { x: 4, y: 5 } }
        it { should eq ERROR_TYPES[:no_error] }
      end

      context 'next row' do
        let(:location) { { x: 6, y: 5 } }
        it { should eq ERROR_TYPES[:no_error] }
      end
    end
  end

  describe 'a wall cannot cross another wall' do
    context 'horizontal walls' do
      let(:variety) { :vertical_wall }
      include_context('walls present at', horizontal: [{ x: 5, y: 5 }])

      context 'crossing' do
        let(:location) { { x: 6, y: 4 } }
        it { should eq ERROR_TYPES[:crossing_wall] }
      end

      context 'one off one direction' do
        let(:location) { { x: 5, y: 4 } }
        it { should eq ERROR_TYPES[:no_error] }
      end

      context 'one off in the other' do
        let(:location) { { x: 7, y: 4 } }
        it { should eq ERROR_TYPES[:no_error] }
      end

      context 'one off in the third direction' do
        let(:location) { { x: 6, y: 3 } }
        it { should eq ERROR_TYPES[:no_error] }
      end

      context 'one off in the fourth' do
        let(:location) { { x: 6, y: 5 } }
        it { should eq ERROR_TYPES[:no_error] }
      end
    end

    context 'vertical walls' do
      let(:variety) { :horizontal_wall }
      include_context('walls present at', vertical: [{ x: 5, y: 5 }])

      context 'crossing' do
        let(:location) { { x: 4, y: 6 } }
        it { should eq ERROR_TYPES[:crossing_wall] }
      end

      context 'one off one direction' do
        let(:location) { { x: 4, y: 5 } }
        it { should eq ERROR_TYPES[:no_error] }
      end

      context 'one off in the other' do
        let(:location) { { x: 4, y: 7 } }
        it { should eq ERROR_TYPES[:no_error] }
      end

      context 'one off in the third direction' do
        let(:location) { { x: 3, y: 6 } }
        it { should eq ERROR_TYPES[:no_error] }
      end

      context 'one off in the fourth' do
        let(:location) { { x: 5, y: 6 } }
        it { should eq ERROR_TYPES[:no_error] }
      end
    end
  end

  describe 'a wall cannot extend off the board' do
    context 'vertical wall' do
      let(:variety) { :vertical_wall }

      context 'off left edge' do
        let(:location) { { x: 1, y: rand(1..8) } }
        it { should eq ERROR_TYPES[:wall_out_of_bounds] }
      end

      context 'off top edge' do
        let(:location) { { x: rand(2..9), y: 0 } }
        it { should eq ERROR_TYPES[:wall_out_of_bounds] }
      end

      context 'off right edge' do
        let(:location) { { x: 10, y: rand(1..8) } }
        it { should eq ERROR_TYPES[:wall_out_of_bounds] }
      end

      context 'off bottom edge' do
        let(:location) { { x: rand(2..9), y: 9 } }
        it { should eq ERROR_TYPES[:wall_out_of_bounds] }
      end
    end

    context 'horizontal wall' do
      let(:variety) { :horizontal_wall }

      context 'off left edge' do
        let(:location) { { x: 0, y: rand(1..9) } }
        it { should eq ERROR_TYPES[:wall_out_of_bounds] }
      end

      context 'off top edge' do
        let(:location) { { x: rand(1..9), y: 1 } }
        it { should eq ERROR_TYPES[:wall_out_of_bounds] }
      end

      context 'off right edge' do
        let(:location) { { x: 9, y: rand(1..9) } }
        it { should eq ERROR_TYPES[:wall_out_of_bounds] }
      end

      context 'off bottom edge' do
        let(:location) { { x: rand(1..9), y: 10 } }
        it { should eq ERROR_TYPES[:wall_out_of_bounds] }
      end
    end
  end
end
