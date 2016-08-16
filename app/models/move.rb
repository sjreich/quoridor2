class Move < ApplicationRecord
  enum variety: { vertical_board: 0, horizontal_board: 1, translation: 2 }
  belongs_to :game

  before_create :set_ordinal

  validates :ordinal, uniqueness: { scope: :game }

  private

  def set_ordinal
    return if ordinal.present?
    last_ordinal = Move.where(game_id: game_id).maximum(:ordinal).to_i
    self.ordinal = last_ordinal + 1
  end
end
