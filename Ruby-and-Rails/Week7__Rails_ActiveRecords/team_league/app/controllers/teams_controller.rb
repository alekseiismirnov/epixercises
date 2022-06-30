class TeamsController < ApplicationController
  def index
    @teams = Team.all
    render :index
  end

  def show
    @team = Team.find params[:id]

    render :show
  end

  def destroy
    team = Team.find params[:id]
    team.destroy

    redirect_to request.referrer
  end

  def edit
    @team = Team.find params[:id]

    render :edit
  end

  def update
    @team = Team.find params[:id]
    if @team.update(team_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  def new
    @team = Team.new
    render :new
  end

  def create
    Team.create(team_params)

    redirect_to action: :index
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
