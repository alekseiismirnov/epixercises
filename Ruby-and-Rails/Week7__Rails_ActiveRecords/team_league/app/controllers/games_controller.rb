class GamesController < ApplicationController
  def new
    @game = Game.new
    render :new
  end

  def create
    @game = Game.create(game_params)
    flash.notice = 'Game added'
    redirect_to action: :new
  end

  private

  def game_params
    params.require(:game).permit(:winner_id, :loser_id, :scores)
  end
end
