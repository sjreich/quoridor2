class MovesController < ApplicationController
  before_action :fetch_game

  def create
    @game.moves.create
    redirect_to @game
  end

  private

  def fetch_game
    @game = Game.find(params[:game_id])
  end
end
