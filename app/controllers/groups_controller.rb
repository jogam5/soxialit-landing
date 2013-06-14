class GroupsController < ApplicationController
  #before_filter :authenticate_user!
  #load_and_authorize_resource
  layout "index", :only => :index

  def index
    @groups = Group.all
    #Groups I am suscribed
    if user_signed_in?
      @suscribed_groups = current_user.groups
    else
      @suscribed_groups = User.find(1).groups
    end
  end

  def show
    @group = Group.find_by_name(params[:name])
    @stories = Group.get_all_stories(@group)
    @all_stories = @stories.paginate(:page => params[:page], :per_page => 10)
    @new = Group.get_new_stories(@group)
    @new_stories = @new.paginate(:page => params[:page], :per_page => 10)
    @top_stories = Group.get_top_stories(@group)
    @top = @top_stories.paginate(:page => params[:page], :per_page => 10).sort! {|mp1, mp2| mp2.reputation(mp2) <=> mp1.reputation(mp1) }
    @trend_stories = Group.get_trend_stories(@group)
    @trend = @trend_stories.sort! {|mp1, mp2| mp2.reputation(mp2) <=> mp1.reputation(mp1) }
    #Get profile picture of group creator
    @group_creator = User.find(@group.user_id)
    
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
    @group.update_attributes(user_id: current_user.id)
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

  def square
    @group = Group.find_by_name(params[:name])
    @stories = Group.get_all_stories(@group)
    @all_stories = @stories.paginate(:page => params[:page], :per_page => 10)
    @new = Group.get_new_stories(@group)
    @new_stories = @new.paginate(:page => params[:page], :per_page => 10)
    @top_stories = Group.get_top_stories(@group)
    @top = @top_stories.paginate(:page => params[:page], :per_page => 10).sort! {|mp1, mp2| mp2.reputation(mp2) <=> mp1.reputation(mp1) }
    @trend_stories = Group.get_trend_stories(@group)
    @trend = @trend_stories.sort! {|mp1, mp2| mp2.reputation(mp2) <=> mp1.reputation(mp1) }
  end

  def list
    @group = Group.find_by_name(params[:name])
    @stories = Group.get_all_stories(@group)
    @all_stories = @stories.paginate(:page => params[:page], :per_page => 10)
    @new = Group.get_new_stories(@group)
    @new_stories = @new.paginate(:page => params[:page], :per_page => 10)
    @top_stories = Group.get_top_stories(@group)
    @top = @top_stories.paginate(:page => params[:page], :per_page => 10).sort! {|mp1, mp2| mp2.reputation(mp2) <=> mp1.reputation(mp1) }
    @trend_stories = Group.get_trend_stories(@group)
    @trend = @trend_stories.sort! {|mp1, mp2| mp2.reputation(mp2) <=> mp1.reputation(mp1) }
  end
end