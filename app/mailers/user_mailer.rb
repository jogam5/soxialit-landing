class UserMailer < ActionMailer::Base
   default :from => "info@soxialit.com"
   
   def followers(user, current)
      @user = user
      @user_following = current
      mail(:to =>  user.email, :subject => "Tienes un nuevo seguidor en Soxialit")
   end
   
   def lov_item(user, current, product)
      @user = user
      @user_following = current
      @product = product
      mail(:to =>  user.email, :subject => "Tu item tiene un nuevo Like")
   end
   
   def lov_micropost(user, current, micropost)
      @user = user
      @user_following = current
      @micropost = micropost
      mail(:to =>  user.email, :subject => "Tu Micropost tiene un nuevo Like")
   end
   
   def registration_confirmation(user)
      mail(:to =>  user.email, :subject => "Test")
   end
end
