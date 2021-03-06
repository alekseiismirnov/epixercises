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

  def destroy
    animal = Animal.find(params[:animal_id])
    sight = Sight.find(params[:id])
    sight.destroy

    redirect_to animal_path(animal)
  end

  def index
    min_date = params['min_date']
    max_date = params['max_date']
    region_id = params['region_id']

    @sights = if !(min_date.blank? && max_date.blank?)
                Sight.where("date >= '#{Date.parse(min_date)}' AND date <= '#{Date.parse(max_date)}'")
              elsif region_id
                Sight.where("region_id = #{region_id}")
              else
                Sight.all
              end

    render :index
  end

  private

  def sight_params
    params.require(:sight).permit(:location, :region_id, :date)
  end
end
