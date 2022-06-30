class TournamentsController < ApplicationController
  def new
    @tournament = Tournament.new
    render 'new'
  end

  def create
    tournament = Tournament.create(tournament_params)

    redirect_to tournament_path(tournament)
  end

  def show
    @tournament = Tournament.find(params[:id])
    @teams_names = @tournament.order.map { |id| Team.find(id).name }

    render 'show'
  end

  def tournament_params
    params.require(:tournament).permit(order: [])
  end
end
