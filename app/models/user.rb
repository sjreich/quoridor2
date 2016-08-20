class User < ApplicationRecord
  def games
    Game.where(player1: id)
      .or(Game.where(player2: id))
      .or(Game.where(player3: id))
      .or(Game.where(player4: id))
  end

  has_secure_password
end
