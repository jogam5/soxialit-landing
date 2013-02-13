class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :list_items, :list_projects, :favorites, 
                 :followers, :following, :fotografo, :boutique, :fashionlover, :blogger, :bio, :designer, :index, :ubicacion, :product_modal ]
  #before_filter :authenticate_user!, :only => [:index, :new, :edit, :create, :update]
  load_and_authorize_resource

  def index
    #@users = User.all
    @users = User.find(:all, :order => "created_at DESC")   #Show in reverse order
    @fashionlovers = find_fashionlover(@users)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    #@user = User.find(params[:id])
    @user = User.find_by_username(params[:username])
    @products = product_ok(@user.products)
    @activities = @user.activities.order("created_at DESC")
    @comment = Comment.new
    
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
            product.destroy
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
    #@user = User.find(params[:id])
    @user = User.find_by_username(params[:username])
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
    #@user = User.find(params[:id])
    @user = User.find_by_username(params[:username])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Tus datos fueron actualizados correctamente.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def following
    #@user = User.find(params[:id])
    @user = User.find_by_username(params[:username])
    @users = @user.followed_users
    respond_to do |format|
      format.js
    end
  end

  def followers
    @user = User.find_by_username(params[:username])
    #@user = User.find(params[:id])
    @users = @user.followers
    respond_to do |format|
      format.js
    end
  end
  
  def bio
     @user = User.find(params[:user_id])
  end
  
  def list_projects
     #@user = User.find(params[:id])
     @user = User.find_by_username(params[:username])
     @projects = @user.projects.find(:all, :order => 'created_at DESC')
  end

  def list_items
    #@user = User.find(params[:id])
    @user = User.find_by_username(params[:username])
    @products = product_ok(@user.products)
    respond_to do |format|
      format.js
    end
  end

  def favorites
    #@user = User.find(params[:id], :order => "created_at DESC")
    @user = User.find_by_username(params[:username], :order => "created_at DESC")
    respond_to do |format|
      format.js
    end
  end
  
  def designer
   @users = User.all
   @designers = find_designer(@users)
  end
  
  def find_designer(users)
     designers = []
     users.each do |user|
        if user.roles.first.name == "designer"
           designers << user
        end
     end
     return designers
  end
  
  def product_modal
  end
  
  def fashionlover
     @users = User.all
     @fashionlovers = find_fashionlover(@users)
    end

 def find_fashionlover(users)
    fashionlover = []
    users.each do |user|
       if user.roles.first.name == "fashion lover"
          fashionlover << user
       end
    end
    return fashionlover
 end
    
  def boutique
     @users = User.all
     @boutiques = find_boutiques(@users)
  end

  def find_boutiques(users)
       boutiques = []
       users.each do |user|
          if user.roles.first.name == "boutique store"
             boutiques << user
          end
       end
       return boutiques
  end
       
  def blogger
      @users = User.all
      @bloggers = find_bloggers(@users)
  end

  def find_bloggers(users)
     bloggers = []
     users.each do |user|
        if user.roles.first.name == "blogger"
           bloggers << user
        end
     end
     return bloggers
  end
           
   def fotografo
     @users = User.all
     @fotografos =  User.find(:all, :conditions )
     @fotografos = find_fotografos(@users)
   end

   def find_fotografos(users)
       fotografos = []
       users.each do |user|
          if user.roles.first.name == "fotografo"
             fotografos << user
          end
       end
       return fotografos
    end
    
    def ubicacion
        @user = User.find(params[:user_id])
        @direction = Direction.new
        @address = @user.direction
    end
    
    def perfil
        @user = User.find(params[:user_id])
     end
   
   def notificacion
      @user = User.find(params[:user_id])
   end
end