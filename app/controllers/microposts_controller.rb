class MicropostsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def new
    @micropost = Micropost.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @micropost }
    end
  end

  def create
    @micropost = current_user.microposts.create(params[:micropost])
    if @micropost.valid?
      @micropost.save!
      @micropost.activities.create(:user_id => current_user.id, :action => "create")
    else
      render 'new'
      flash[:notice] = 'Ingresa URL valida' 
    end
    respond_to do |format|
      if @micropost.save
        format.html { redirect_to root_url, notice: 'Micropost was successfully created.' }
        format.js
      else
        format.html { redirect_to root_url, notice: 'Ingresa una URL valida' }
      end
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end
end