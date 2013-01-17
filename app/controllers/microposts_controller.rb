class MicropostsController < ApplicationController
  before_filter :authenticate_user!
  #load_and_authorize_resource

  def new
    @micropost = Micropost.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @micropost }
    end
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    @micropost.save!
    @micropost.activities.create(:user_id => current_user.id, :action => "create")
    Micropost.delay.publish_link_facebook(@micropost)
    redirect_to :back
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Micropost eliminado correctamente' }
    end
  end
  
  def lovs
    value = params[:type] == "up" ? 1 : -1
    @micropost = Micropost.find(params[:id])
    @micropost.add_evaluation(:lovs, value, current_user)
    @micropost.activities.create(:user_id => current_user.id, :action => "like")
     respond_to do |format|
        format.js
      end
  end
end