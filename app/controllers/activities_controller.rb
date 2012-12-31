class ActivitiesController < ApplicationController
  after_save :expire_get_feed_cache

  def create
  end

  def expire_get_feed_cache
  	Rails.cache.delete('get_feed')
  end
end