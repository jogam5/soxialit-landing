class ActivitiesController < ApplicationController
  after_create :expire_feed_cache
  after_destroy :expire_feed_cache

  def create
  end

  def expire_feed_cache
  	user = current_user
    Rails.cache.delete('feed_user_#{user.id}')
  end
end