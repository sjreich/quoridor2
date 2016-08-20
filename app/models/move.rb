class Move < ApplicationRecord
  enum variety: { vertical_board: 0, horizontal_board: 1, translation: 2 }
  belongs_to :game
end
