class Game < ApplicationRecord
  belongs_to :player1, class_name: 'User'
  belongs_to :player2, class_name: 'User'
  belongs_to :player3, class_name: 'User', optional: true
  belongs_to :player4, class_name: 'User', optional: true

  has_many :moves, -> { order('ordinal') }

  def current_player_number
    moves.count % players.count + 1
  end

  def horizontal_wall_coordinates
    moves.select(&:horizontal_wall?).map(&:to_coordinates)
  end

  def vertical_wall_coordinates
    moves.select(&:vertical_wall?).map(&:to_coordinates)
  end

  def players
    (1..4).each_with_object([]) do |num, players|
      next unless send("player#{num}".to_sym)
      players << Player.new(num, moves_for_player(num))
    end
  end

  def moves_for_player(player_num)
    moves.select { |move| move.player == player_num }
  end

  STARTING_WALL_COUNT = 10

  STARTING_LOCATIONS = {
    1 => { x: 5, y: 1 },
    2 => { x: 5, y: 9 },
    3 => { x: 1, y: 5 },
    4 => { x: 9, y: 5 }
  }.freeze
end
