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
      flash.notice = 'Division successfuly updated'
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    division = Division.find(params[:id])
    division.destroy

    redirect_to action: :index
  end

  def new
    @division = Division.new

    render :new
  end

  def create
    @division = Division.new(division_params)
    if @division.save
      flash.notice = 'Division successfuly created'
      redirect_to divisions_path
    else
      render :new
    end
  end

  private

  def division_params
    params.require(:division).permit(:name)
  end
end
