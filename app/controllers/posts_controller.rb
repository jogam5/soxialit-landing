class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  before_filter :avoid_nil, only: :show

  def edit
    @post = Post.find(params[:id])
    @slides = @post.slides
  end
  
  def new
    @post = current_user.posts.create(:url => "http://")
    @slides = @post.slides
    respond_to do |format|
      format.html
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @photos = @post.slides
    @comment = Comment.new
    @comments = @post.comments
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @post.update_attributes(params[:post])
    redirect_to @post
  end

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    Activity.expire_feed_cache(@post.user)
    @post.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Micropost eliminado correctamente' }
    end
  end

  def publish
    @post = Post.find(params[:post_id])
    @user = @post.user
    if @post.status == false
       @post.update_attributes(:status => true)
       @post.activities.create(:user_id => current_user.id, :action => "create")
       @followers_list = @user.followers.map do |u|
         { :id => u.id, :follower_name => u.nickname}
       end
      
       require 'json'
        url = 'http://10.0.1.38:3000/push'
        uri = URI.parse(url)
        post_params = {
           :title => @post.title,
           :body => @post.body,
           :user_id => @post.user_id,
           :name => @user.nickname,
           :followers => @followers_list
        }
 
       req = Net::HTTP::Post.new(uri.path)
       req.body = JSON.generate(post_params)
       req["Content-Type"] = "application/json"
       http = Net::HTTP.new(uri.host, uri.port)
       http.start {|htt| htt.request(req)}
       
       Activity.expire_feed_cache(@user)
       Post.delay.publish_post_facebook(@post) unless @user.fb == false
    else
    end
    redirect_to :back
  end

  def avoid_nil
   @posts = Post.all
   @posts.each do |post|
     if post.title.nil? && post.body.nil?
        post.destroy
     end
   end
  end
  
  def likes
    value = params[:type] == "up" ? 1 : -1
    @post = Post.find(params[:id])
    @post.add_evaluation(:likes, value, current_user)
    @post.activities.create(:user_id => current_user.id, :action => "like")
    @user = User.find(@post.user_id)
    Post.delay.publish_post_like_facebook(@post, current_user) unless current_user.fb == false
    if !@user.notification.nil?
       if @user.notification.lov_post == true
          UserMailer.lov_post(@user, current_user, @post).deliver
       end
    end
    respond_to do |format|
      format.js
    end
  end
end