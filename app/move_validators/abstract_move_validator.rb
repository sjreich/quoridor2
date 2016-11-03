require_relative 'helpers/general_helpers'

class AbstractMoveValidator
  include GeneralHelpers

  attr_reader :move, :prior_game_state, :next_validator

  def initialize(move, prior_game_state)
    @move = move
    @prior_game_state = prior_game_state
    @next_validator = next_validator
  end

  def validate
    raise NotImplementedError
  end

  def next_validator
    nil
  end
end
