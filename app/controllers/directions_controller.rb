class DirectionsController < ApplicationController
  
  def new
    Direction.new
  end

  def create
    @direction = current_user.build_direction(params[:direction])
    logger.debug "#{@product.id}"
    
    respond_to do |format|
      if @direction.save
        format.html { redirect_to :back }
        format.js
      end
    end
  end
end