class StaticPagesController < ApplicationController

  layout "feed", :only => :home

  def home
    @stats = Rails.cache.stats.first.last unless Rails.env.development?
  	@comment = Comment.new
    @micropost = Micropost.new
    @last = Micropost.last
  	if user_signed_in?
  		@feed_items = User.feed_cached(current_user)  if Rails.env.development?
      #@feed_items = current_user.feed 
      @feed_items = User.feed_cached(current_user) if Rails.env.production?
  	else
  	  @feed_items = User.feed_cached(User.find(1)) if Rails.env.production?
      @feed_items = User.feed_cached(User.find(47)) if Rails.env.development?
      #@feed_items = User.first.feed 
  	end
  end

  def preview
    @Micropost = Micropost.find(params[:micropost])
  end

  def about
    @users = User.limit(6)
  end
  
  def soxialit
    respond_to do |format|
      format.js
    end
  end

  def faq
    respond_to do |format|
      format.js
    end
  end
  
  def privacy
    respond_to do |format|
      format.js
    end
  end

   def team
    respond_to do |format|
      format.js
    end
  end
  
  def term
    respond_to do |format|
      format.js
    end
  end

  def sell
    respond_to do |format|
      format.js
    end
  end

  def buy
    respond_to do |format|
      format.js
    end
  end

  def examples
    respond_to do |format|
      format.js
    end
  end

  def guides
    respond_to do |format|
      format.js
    end
  end

  def term
    respond_to do |format|
      format.js
    end
  end
  
  def payment
  end

  def registro
    @users = User.all
    @fotografos = []
    @users.each do |user|
      if user.roles.first.name == "fotografo"
        @fotografos << user
      end
    end
  end
  
  def demo
    @products = [Product.find(257),Product.find(258), Product.find(259), Product.find(260), Product.find(261), Product.find(262)]
  end

  def items
    respond_to do |format|
      format.js
    end
  end

  def biografia
    respond_to do |format|
      format.js
    end
  end
  
  def men_heute
    @products = [Product.find(230),Product.find(231), Product.find(232), Product.find(241), Product.find(242), Product.find(243)]
  end
  
  def modal_item
     @product = Product.find(params[:product_id])
  end
  
  def arbol_viento
   @products = [Product.find(233), Product.find(234), Product.find(235)]
  end
  
  def modal_post
    @micropost = Micropost.new
    @microposts = Micropost.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @microposts.tokens(params[:q]) }
      format.js
    end
  end

  def las7depauline
     @microposts = [Micropost.find(587), Micropost.find(585), Micropost.find(586), Micropost.find(553), Micropost.find(543), Micropost.find(541), Micropost.find(539), Micropost.find(528), Micropost.find(527), Micropost.find(518), Micropost.find(513), Micropost.find(484), Micropost.find(483), Micropost.find(482), Micropost.find(476), Micropost.find(467), Micropost.find(463), Micropost.find(459), Micropost.find(456), Micropost.find(465), Micropost.find(466), Micropost.find(460), Micropost.find(400) ,Micropost.find(401), Micropost.find(402) ,Micropost.find(403), Micropost.find(404)]
     #@test = [Micropost.find(25)]
     @newsletter = @microposts.paginate(:page => params[:page], :per_page => 7)
  end  
end