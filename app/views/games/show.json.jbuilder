json.game_id               @game.id
json.current_player_number @game.current_player_number

json.players @game.players do |player|
  json.number          player.number
  json.position        player.position
  json.walls_remaining player.walls_remaining
end

json.walls do
  json.horizontal @game.horizontal_wall_coordinates
  json.vertical   @game.vertical_wall_coordinates
end
