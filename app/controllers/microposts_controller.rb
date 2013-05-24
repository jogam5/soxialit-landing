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
    @groups = Group.all
    if !@micropost.picture.present?
      if !@micropost.thumbnail.nil?
        images = @micropost.thumbnail
        @img = images.split( /\r?\n- / )
      else
        @img = @micropost.thumbnail
      end
    else
      @img = @micropost.picture
    end

  end

  def create
   @micropost = current_user.microposts.build(params[:micropost])
    #@micropost.remote_picture_url = @micropost.thumbnail
    @micropost.save!
    @micropost.activities.create(:user_id => current_user.id, :action => "create")
    Activity.expire_feed_cache(current_user)
    Micropost.delay.publish_link_facebook(@micropost) unless @micropost.user.fb == false
    if !@micropost.picture.present?
      require 'embedly'
      require 'json'
      embedly_api = Embedly::API.new :key => '80abb9f8804a4cad90d3f21d33b49037',
              :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
      obj = embedly_api.extract :url => @micropost.url
      #puts obj[0].marshal_dump
      json_obj = JSON.pretty_generate(obj[0].marshal_dump)
      result = JSON.parse(json_obj)
      images = []
      result['images'].each do |s|
        size = s['width'].to_i
        if size >= 400
          images << s['url']
        end
      end
      puts images
      @micropost.update_attributes(thumbnail: images)
      @micropost.update_attributes(url: result['url'])
      @micropost.update_attributes(title: result['title'])
      @micropost.update_attributes(provider: result['provider_url'])
      puts json_obj
    respond_to do |format|
       format.html { redirect_to edit_micropost_path(@micropost)}
    end 
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    Activity.expire_feed_cache(@micropost.user)
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Micropost eliminado correctamente' }
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
    value = params[:type] 
    @micropost = Micropost.find(params[:id])
    if value == "up"
      @micropost.add_or_update_evaluation(:votes, 1, current_user)
    else
      if @micropost.has_evaluation?(:votes, current_user)
        @micropost.add_or_update_evaluation(:votes, 0, current_user)
      else
        @micropost.add_or_update_evaluation(:votes, -1, current_user)
      end
    end
=begin
    voto = params[:type]
    logger.debug "Tipo voto: #{voto}"
    @micropost = Micropost.find(params[:id])
    if voto == "up"
      @x = @micropost.reputation_for(:ups).to_i
      logger.debug "Valor actual: #{@x}"
      @value = @x + 1
      @value.to_i
      logger.debug "Voto despues: #{@value}"
      @micropost.add_or_update_evaluation(:ups, @value, current_user)
      logger.debug "Reputation after: #{@micropost.reputation_for(:ups).to_i}"
    else
      @x = @micropost.reputation_for(:ups).to_i
      logger.debug "Valor actual: #{@x}"
      @value = @x - 1
      logger.debug "Voto despues: #{@value}"
      @micropost.decrease_evaluation(:ups, @value, current_user)
      logger.debug "Reputation after: #{@micropost.reputation_for(:ups).to_i}"
    end
=end
     #== "up" ? 1 : -1
   # @micropost = Micropost.find(params[:id])
   # @x = @micropost.reputation_for(:votes)
    #logger.debug "Valor actual: #{@x}"
    #logger.debug "Voto nuevo: #{voto}"
    #@value = @x + (voto)
    #@value
    #logger.debug "Voto despues: #{@value}"
  
    #@micropost.add_or_update_evaluation(:votes, voto, current_user)
    
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
    @groups = Group.all
    @micropost = Micropost.find_by_id(params[:id])
    if !@micropost.picture.present?
      if !@micropost.thumbnail.nil?
        images = @micropost.thumbnail
        @img = images.split( /\r?\n- / )
      else
        @img = @micropost.thumbnail
      end
    else
      @img = @micropost.picture
    end
    respond_to do |format|
      if @micropost.update_attributes(params[:micropost])
        format.html { redirect_to @micropost, notice: '' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
end