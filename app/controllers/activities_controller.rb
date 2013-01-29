class ActivitiesController < ApplicationController
  #after_filter :expire_feed_cache, only: :create

  def create
  end

  #def expire_feed_cache
  #	user = current_user
  #  Rails.cache.delete('feed_user_#{user.id}')
  #end
end