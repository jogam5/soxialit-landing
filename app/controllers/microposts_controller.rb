class MicropostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :modal_micropost, :microposts_lov, :microposts_order, :microposts_search]
  #load_and_authorize_resource

  def new
    @micropost = Micropost.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @micropost }
    end
  end
  
  def index  
     @microposts = Micropost.page(params[:page]).per_page(50).find(:all, :order => "created_at DESC")
     @search = Micropost.search(params[:search])
  end
  
  def microposts_lov
     @microposts = Micropost.page(params[:page]).per_page(50).find_with_reputation(:lovs, :all, order: 'lovs desc')
  end
  
  def microposts_order
      @microposts = Micropost.page(params[:page]).per_page(50).find(:all, :order => "created_at DESC")
  end
  
  def microposts_search
     @search = Micropost.search(params[:search])
     @microposts = @search.page(params[:page]).per_page(50)
  end

  def show
    @micropost = Micropost.find_by_id(params[:id])
    @posts = Micropost.all.last(3)
    if @micropost.nil?
      flash[:error] = "No se ha encontrado el Post."
      redirect_to microposts_path
    else
       @user = @micropost.user
       @comment = Comment.new
       @comments = @micropost.comments
       respond_to do |format|
         format.html # show.html.erb
       end
    end
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    @micropost.remote_picture_url = @micropost.thumbnail
    @micropost.save!
    @micropost.activities.create(:user_id => current_user.id, :action => "create")
    Activity.expire_feed_cache(current_user)
    Micropost.delay.publish_link_facebook(@micropost) unless @micropost.user.fb == false
    redirect_to root_path
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
    if !@user.notification.nil?
       if @user.notification.lov_micropost == true
         UserMailer.lov_micropost(@user, current_user, @micropost).deliver 
      end
    end
     respond_to do |format|
        format.js
      end
  end
  
  def modal_micropost
     @micropost = Micropost.find(params[:micropost_id])
  end
  
end