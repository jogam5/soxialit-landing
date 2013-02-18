class StaticPagesController < ApplicationController
  layout "registro", :only => [ :registro ]
  layout "feed", :only => [:home]
  
  def home
    @stats = Rails.cache.stats.first.last unless Rails.env.development?
  	@comment = Comment.new
    @micropost = Micropost.new
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
  end
  
  def men_heute
     @products = [Product.find(747), Product.find(748), Product.find(749)]
  end
  
  def modal_item
     @product = Product.find(params[:product_id])
  end
    
end