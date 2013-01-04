class StaticPagesController < ApplicationController
  def home
    @stats = Rails.cache.stats.first.last unless Rails.env.development?
  	@comment = Comment.new
    @micropost = Micropost.new
  	if user_signed_in?
  		#feed_items = current_user.feed_cached
      @feed_items = current_user.feed
  	else
  	  #@feed_items = User.find(1).feed_cached
      @feed_items = User.first.feed
  	end
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