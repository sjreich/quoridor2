class Move < ApplicationRecord
  belongs_to :game
  enum variety: { vertical_wall: 0, horizontal_wall: 1, translation: 2 }

  validates :variety, presence: true
  before_save :validate_against_rules
  before_create :set_ordinal
  validates :ordinal, uniqueness: { scope: :game }

  def wall?
    %w(horizontal_wall vertical_wall).include? variety.to_s
  end

  def vertical_wall?
    variety.to_s == 'vertical_wall'
  end

  def horizontal_wall?
    variety.to_s == 'horizontal_wall'
  end

  def translation?
    variety.to_s == 'translation'
  end

  def to_coords
    { x: x, y: y }
  end

  def simple_translation?
    translation? && absolute_coords == [0, 1]
  end

  def straight_jump?
    translation? && absolute_coords == [0, 2]
  end

  def diagonal_jump?
    translation? && absolute_coords == [1, 1]
  end

  private

  def absolute_coords
    to_coords.values.map(&:abs).sort
  end

  def set_ordinal
    return if ordinal.present?
    last_ordinal = Move.where(game_id: game_id).maximum(:ordinal).to_i
    self.ordinal = last_ordinal + 1
  end

  def validate_against_rules
    MoveValidator.new(self, game.state).validate
  end
end
