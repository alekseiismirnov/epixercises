class AnimalsController < ApplicationController
  def show
    @animal = Animal.find(params[:id])

    render :show
  end

  def index
    @animals = Animal.all

    render :index
  end

  def new
    @animal = Animal.new

    render :new
  end

  def create
    @animal = Animal.new(animal_params)
    if @animal.save
      redirect_to animals_path
    else
      render :new
    end
  end

  def edit
    @animal = Animal.find(params[:id])

    render :edit
  end

  def update
    @animal = Animal.find(params[:id])
    if @animal.update(animal_params)
      redirect_to animals_path
    else
      render :edit
    end
  end

  private 

  def animal_params
    params.require(:animal).permit(:species)
  end
end
