class MicropostsController < ApplicationController
  before_filter :authenticate_user!
  #load_and_authorize_resource

  def new
    @micropost = Micropost.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @micropost }
    end
  end

  def create
    embedly_api = Embedly::API.new :key => '7f6cf7cec28511e0866c4040d3dc5c07',
        :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    @micropost = current_user.microposts.create(params[:micropost])
    url = @micropost.url
    obj = embedly_api.oembed :url => url       
    @micropost.title = obj[0].title
    @micropost.provider = obj[0].provider_url
    @micropost.description = obj[0].description
    @micropost.thumbnail = obj[0].thumbnail_url
    if @micropost.valid?
       @micropost.save!
       @micropost.activities.create(:user_id => current_user.id, :action => "create")
    end
    respond_to do |format|
      if @micropost.save
        format.html { redirect_to root_url, notice: 'Micropost creado correctamente.' }
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
  
  def lovs
    value = params[:type] == "up" ? 1 : -1
    @micropost = Micropost.find(params[:id])
    @micropost.add_evaluation(:lovs, value, current_user)
    @micropost.activities.create(:user_id => current_user.id, :action => "like")
     respond_to do |format|
        format.js
      end
  end
end