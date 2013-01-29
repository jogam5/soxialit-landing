class StaticPagesController < ApplicationController
  def home
    @stats = Rails.cache.stats.first.last unless Rails.env.development?
  	@comment = Comment.new
    @micropost = Micropost.new
  	if user_signed_in?
  		@feed_items = current_user.feed_cached(current_user)  if Rails.env.production?
      @feed_items = current_user.feed if Rails.env.development?
  	else
  	  @feed_items = User.find(1).feed_cached(User.find(1)) if Rails.env.production?
      #@feed_items = User.find(1).feed
      @feed_items = User.first.feed if Rails.env.development?
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
end