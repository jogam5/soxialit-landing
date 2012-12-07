class CommentsController < ApplicationController

  def index
    @comments = Comment.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @comment = Comment.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @comment = current_user.comments.build(params[:comment])   
    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end