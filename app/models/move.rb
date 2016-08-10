class Move < ApplicationRecord
  enum variety: { vertical_board: 0, horizontal_board: 1, translation: 2 }
  belongs_to :game

  # require that ordinal be present
  # figure out how to auto-increment the ordinal
  # if you delete a move, delete all the moves after it too?
end
