class SlidesController < ApplicationController

  def create
	@slide = Slide.create(params[:slide])
  end

  def destroy
  	@slide = Slide.find(params[:id])
  	@slide.destroy
  end
end