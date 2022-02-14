class SightsController < ApplicationController
  def new
    @animal = Animal.find(params[:animal_id])
    @sight = @animal.sights.new

    render :new
  end

  def create
    @animal = Animal.find(params[:animal_id])
    # tests work w/o this:
    # location = params[:sight][:location].split(',').map(&:to_f)
    @sight = @animal.sights.new(sight_params)

    if @sight.save
      redirect_to animal_path(@animal)
    else
      render :new
    end
  end

  private

  def sight_params
    params.require(:sight).permit(:location)
  end
end
