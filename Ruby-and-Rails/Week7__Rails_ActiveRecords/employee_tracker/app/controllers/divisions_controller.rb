class DivisionsController < ApplicationController
  def index
    @divisions = Division.all
    render :index
  end

  def edit
    @division = Division.find(params[:id])
    render :edit
  end

  def update
    @division = Division.find(params[:id])
    if @division.update(division_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  private

  def division_params
    params.require(:division).permit(:name)
  end
end
