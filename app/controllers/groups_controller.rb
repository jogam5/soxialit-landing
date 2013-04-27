class GroupsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @group = Group.find_by_name(params[:name])
    #@group = Group.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  def new
    @group = Group.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @group = Group.find_by_name(params[:name])
  end

  def create
    @group = Group.new(params[:group])
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @group = Group.find_by_name(params[:name])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
end