module GeneralHelpers
  def players
    prior_game_state[:players]
  end

  def current_player_positions
    players.map do |player|
      player[:position]
    end
  end

  def current_player_info
    players.find { |player| player[:number] == move.player }
  end
end
