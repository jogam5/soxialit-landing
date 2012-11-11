class FeedbacksController < ApplicationController
  
  def index
    @feedback = Feedback.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feedback }
    end
  end

  def create
    @feedback = current_user.feedbacks.build(params[:feedback])
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to current_user, notice: 'Gracias por tus comentarios.' }
      else
        format.html { render action: "index" }
      end
    end
  end
end
