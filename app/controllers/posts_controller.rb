class PostsController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new(url: "http://")
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def create
    @post = current_user.posts.create(params[:post])
    @post.save!
    #@post.activities.create(:user_id => current_user.id, :action => "create")
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'El Post fue actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
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
end