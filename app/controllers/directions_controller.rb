class DirectionsController < ApplicationController
  
  def new
    Drection.new
  end

  def create
    @direction = current_user.build_direction(params[:direction])
    respond_to do |format|
      if @direction.save
        format.html { redirect_to :back }
        format.js
      end
    end
  end
end