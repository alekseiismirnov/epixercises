class DivisionsController < ApplicationController
  def index
    @divisions = Division.all
    
    render :index
  end
end
