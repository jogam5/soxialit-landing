class SourcesController < ApplicationController
  def index
    @sources = Source.order(:name)
    respond_to do |format|
      format.html
      format.json { render json: @sources.tokens(params[:q]) }
    end
  end

  def show
  end 
  
end
