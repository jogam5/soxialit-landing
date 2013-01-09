class PostsController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new(params[:post])
    @slides = @post.slides
    respond_to do |format|
      format.html
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @photos = @post.slides
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def create
    @post = current_user.posts.create(params[:post])
    #@post.save!
    #@post.activities.create(:user_id => current_user.id, :action => "create")
    if @post.save
      redirect_to @post
    else
      render "new"
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'El Post fue actualizado correctamente.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Micropost eliminado correctamente' }
    end
  end

  def new_preview
    @post = Post.new(params[:post])
    @photos = @post.slides
    @user = current_user
  end
end