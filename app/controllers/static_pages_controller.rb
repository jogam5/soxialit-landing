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
      format.json { render json: @microposts.map(&:attributes) }
      format.js
    end
  end

  def las7depauline
     @newsletter = Newsletter.page(params[:page]).per_page(7).find(:all, :order => 'created_at DESC')
  end  
end