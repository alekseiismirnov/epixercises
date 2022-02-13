class SightsController < ApplicationController
  def new
    @animal = Animal.find(params[:animal_id])
    @sight = @animal.sights.new

    render :new
  end

  def create
    @animal = Animal.find(params[:animal_id])
    location = params[:sight][:location].split(',').map(&:to_f)
    @sight = @animal.sights.new(location: location)

    if @sight.save
      redirect_to animal_path(@animal)
    else
      render :new
    end
  end
end
