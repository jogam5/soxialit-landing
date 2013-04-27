class MembershipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @group = Group.find(params[:membership][:group_id])
    current_user.subscribe!(@group)
    respond_to do |format|
      format.html { redirect_to @group }
      format.js
    end
  end

  def destroy
    @group = Membership.find(params[:id]).group
    current_user.unsubscribe!(@group)
    respond_to do |format|
      format.html { redirect_to @group }
      format.js
    end
  end
end