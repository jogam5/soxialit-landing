class NotificationsController < ApplicationController
   def new
      Notification.new
   end
   
   def create
      @notification = current_user.build_notification(params[:notification])
      @notification.save!
   end
end
