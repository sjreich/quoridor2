user1 = User.create(username: 'user1', password: 'password')
user2 = User.create(username: 'user2', password: 'password')
user3 = User.create(username: 'user3', password: 'password')
user4 = User.create(username: 'user4', password: 'password')

two_player_game  = Game.create(player1: user1, player2: user2)
four_player_game = Game.create(player1: user1, player2: user2,
                               player3: user3, player4: user4)

Move.create(game: two_player_game, player: 1, variety: :translation, x: 1, y: 0)
Move.create(game: two_player_game, player: 2, variety: :translation, x: -1, y: 0)
Move.create(game: two_player_game, player: 1, variety: :translation, x: 0, y: 1)
Move.create(game: two_player_game, player: 2, variety: :translation, x: 0, y: -1)

Move.create(game: two_player_game, player: 1, variety: :vertical_wall, x: 2, y: 2)
Move.create(game: two_player_game, player: 2, variety: :vertical_wall, x: 4, y: 4)
Move.create(game: two_player_game, player: 1, variety: :horizontal_wall, x: 6, y: 6)
Move.create(game: two_player_game, player: 2, variety: :horizontal_wall, x: 8, y: 8)

Move.create(game: four_player_game, player: 1, variety: :translation, x: 1, y: 0)
Move.create(game: four_player_game, player: 2, variety: :translation, x: -1, y: 0)
Move.create(game: four_player_game, player: 3, variety: :translation, x: 0, y: 1)
Move.create(game: four_player_game, player: 4, variety: :translation, x: 0, y: -1)

Move.create(game: four_player_game, player: 1, variety: :vertical_wall, x: 2, y: 2)
Move.create(game: four_player_game, player: 2, variety: :vertical_wall, x: 4, y: 4)
Move.create(game: four_player_game, player: 3, variety: :horizontal_wall, x: 6, y: 6)
Move.create(game: four_player_game, player: 4, variety: :horizontal_wall, x: 8, y: 8)
