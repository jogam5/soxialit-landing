class StaticPagesController < ApplicationController
  def home
  	@users = User.all
  	@comment = Comment.new
  	if user_signed_in?
  		@feed_items = current_user.feed 
  	else
  		@feed_items = User.first.feed
  	end
  end
  
  def faq
  end
  
  def privacy
  end
  
  def term
  end
end