class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :list_items, :favorites, :followers]
  
  load_and_authorize_resource

  def index
    #@users = User.all
    @users = User.find(:all, :order => "created_at DESC")   #Show in reverse order
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    @products = product_ok(@user.products)
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def product_ok(items)
     products = []
     items.each do |item|
        if item.status == true
           products << item
        end
      end
      return products
  end
      

  def avoid_nil(products)
      items = []
      products.each do |product|
         if product.title.nil? && product.description.nil?
         else
            items << product
         end
       end 
       return items
   end
  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @direction = Direction.new
    @address = @user.direction
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Tus datos fueron actualizados correctamente.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followed_users
    respond_to do |format|
      format.js
    end
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    respond_to do |format|
      format.js
    end
  end

  def list_items
    @user = User.find(params[:id])
    @products = product_ok(@user.products, :order => "created_at DESC")
    respond_to do |format|
      format.js
    end
  end

  def favorites
    @user = User.find(params[:id], :order => "created_at DESC")
    respond_to do |format|
      format.js
    end
  end
end