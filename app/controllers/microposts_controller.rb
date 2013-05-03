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
    if params[:tag]
       @microposts = Micropost.page(params[:page]).per_page(50).tagged_with(params[:tag])
       @search = Micropost.search(params[:search])
       @last = Micropost.last
    else
       @microposts = Micropost.page(params[:page]).per_page(50).find(:all, :order => "created_at DESC")
       @search = Micropost.search(params[:search])
       @last = Micropost.last
    end
     respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @microposts.tokens(params[:q]) }
      format.js
    end
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
    @posts = Micropost.all.last(20)
    @tags = Micropost.tagged_with([@micropost.tag_list], :any => true)

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

  def edit
    @micropost = Micropost.find_by_id(params[:id])
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    @micropost.remote_picture_url = @micropost.thumbnail
    @micropost.save!
    @micropost.activities.create(:user_id => current_user.id, :action => "create")
    Activity.expire_feed_cache(current_user)
    Micropost.delay.publish_link_facebook(@micropost) unless @micropost.user.fb == false
    respond_to do |format|
       format.html { redirect_to :back, notice: 'Tu Post ha sido publicado' }
    end 
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
    @micropost.add_or_update_evaluation(:lovs, value, current_user)
    @micropost.activities.create(:user_id => current_user.id, :action => "like")
    @user = User.find(@micropost.user_id)
    Micropost.delay.publish_link_like_facebook(@micropost, current_user) unless current_user.fb == false
    @followers_list = current_user.followers.map do |u|
         { :id => u.id, :follower_name => u.nickname}
    end

    if !@user.notification.nil?
       if @user.notification.lov_micropost == true
         UserMailer.lov_micropost(@user, current_user, @micropost).deliver 
      end
    end
     respond_to do |format|
        format.js
      end
  end

  def vote
    voto = params[:type] == "up" ? 1 : -1
    @micropost = Micropost.find(params[:id])
    if @micropost.has_evaluation?(:votes, current_user)
      @x = @micropost.reputation_for(:votes).to_i
      @value = @x + (voto)
      @value.to_i
      logger.debug "Voto value #{@value}"
      @micropost.add_or_update_evaluation(:votes, @value, current_user)
    else
      @micropost.add_or_update_evaluation(:votes, voto, current_user)
    end
    #@micropost.activities.create(:user_id => current_user.id, :action => "like")
    #@user = User.find(@micropost.user_id)
    #Micropost.delay.publish_link_like_facebook(@micropost, current_user) unless current_user.fb == false
    #@followers_list = current_user.followers.map do |u|
    #     { :id => u.id, :follower_name => u.nickname}
    #end
  end
  
  def modal_micropost
     @micropost = Micropost.find(params[:micropost_id])
     @tags = Micropost.tagged_with([@micropost.tag_list], :any => true)
     @posts = Micropost.all.last(3)
     @user = @micropost.user
     @comment = Comment.new
     @comments = @micropost.comments
  end

  def collect
     @micropost = Micropost.find(params[:micropost_id])
     #@gallery = Gallery.new
     #@gallery.token = @gallery.generate_token
     @galleries = current_user.galleries
     @pin = Pin.new
  end

  def update
    @micropost = Micropost.find_by_id(params[:id])
    respond_to do |format|
      if @micropost.update_attributes(params[:micropost])
        format.html { redirect_to @micropost, notice: '' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
end