class PostsController < ApplicationController
  before_filter :authenticate_user!
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
    @post.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Micropost eliminado correctamente' }
    end
  end

  def publish
    @post = Post.find(params[:post_id])
    @user =@post.user
    if @post.status == false
       @post.update_attributes(:status => true)
       @post.activities.create(:user_id => current_user.id, :action => "create")
       Post.delay.publish_post_facebook(@post.id)
    else
    end
    redirect_to root_url
  end

  def avoid_nil
   @posts = Post.all
   @posts.each do |post|
     if post.title.nil? && post.body.nil?
        post.destroy
     end
   end
  end
end