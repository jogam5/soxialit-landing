class FeedbacksController < ApplicationController
  
  def index
    @feedback = Feedback.new
    @feedbacks = Feedback.all
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @feedback = current_user.feedbacks.build(params[:feedback])
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to current_user, notice: 'Gracias por tu ayuda.' }
      else
        format.html { render action: "index" }
      end
      format.js
    end
  end
end