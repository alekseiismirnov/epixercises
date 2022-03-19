class PlayersController < ApplicationController
  def new
    @team = Team.find params[:team_id]
    @player = @team.players.new

    render :new
  end

  def create
    @team = Team.find params[:team_id]
    @player = @team.players.new player_params

    if @player.save
      redirect_to team_path(@team)
    else
      render :new
    end
  end

  def edit
    @team = Team.find params[:team_id]
    @player = Player.find params[:id]

    render :edit
  end

  def update
    @team = Team.find params[:team_id]
    @player = Player.find params[:id]

    if @player.update player_params
      redirect_to team_path(@team)
    else
      redirect_to action: :edit
    end
  end

  def destroy
    team = Team.find params[:team_id]
    player = Player.find params[:id]

    player.destroy

    redirect_to team_path(team)
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
