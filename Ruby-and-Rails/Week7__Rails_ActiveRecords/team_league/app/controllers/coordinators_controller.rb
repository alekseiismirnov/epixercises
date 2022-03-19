class CoordinatorsController < ApplicationController
  def new
    @team = Team.find params[:team_id]
    @coordinator = @team.create_coordinator

    render :new
  end

  def update
    @team = Team.find params[:team_id]
    @coordinator = @team.coordinator.update(coordinator_params)

    render :'teams/show'
  end

  def coordinator_params
    params.require(:coordinator).permit(:name, :contacts)
  end
end
