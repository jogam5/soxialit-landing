class MicropostsController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  #load_and_authorize_resource

  def new
    @micropost = Micropost.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @micropost }
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @user = @micropost.user
    @comment = Comment.new
    @comments = @micropost.comments
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    @micropost.save!
    @micropost.activities.create(:user_id => current_user.id, :action => "create")
    Activity.expire_feed_cache(current_user)
    Micropost.delay.publish_link_facebook(@micropost) unless @micropost.user.fb == false
    redirect_to :back
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    Activity.expire_feed_cache(@micropost.user)
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
    @user = User.find(@micropost.user_id)
    Micropost.delay.publish_link_like_facebook(@micropost, current_user) unless current_user.fb == false
    #UserMailer.lov_micropost(@user, current_user, @micropost).deliver
     respond_to do |format|
        format.js
      end
  end
end