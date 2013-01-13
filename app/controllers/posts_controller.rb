class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :avoid_nil, only: :show

  def edit
    @post = Post.find(params[:id])
    @slides = @post.slides
  end

  def new
    @post = current_user.posts.create
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
       @api = Koala::Facebook::API.new(@user.token)
        begin
          options = {
            :message => "Acabo de publicar un nuevo Micropost en Soxialit.",
            :picture => @post.slides.first.picture.to_s,
            :link => "http://soxialit.com/posts/#{@post.id}",
            :name => "#{@post.title} by #{@post.user.nickname}",
            :description => @post.quote
          }
          #@api.put_connections("me", "feed", options)
          rescue Exception=>ex
              puts ex.message
        end
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