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
  
  def avoid_nil(feed)
      products = []
      feed.each do |item|
         if item.activitable.title.nil?
         else
            products << item
         end
       end 
       return products
       logger.debug "Productos:   #{products}\n\n\n\n\n\n"
       
   end
     
  def faq
  end
  
  
  
  def privacy
  end
  
  def term
  end
end