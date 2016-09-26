class MovesController < ApplicationController
  before_action :fetch_game

  def create
    @game.moves.create(move_params)
    redirect_to @game
  end

  private

  def move_params
    params.require(:move).permit(:player, :variety, :x, :y)
  end

  def fetch_game
    @game = Game.find(params[:game_id])
  end
end
