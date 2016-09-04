class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    render formats: :json
  end
end
