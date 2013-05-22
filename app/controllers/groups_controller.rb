class GroupsController < ApplicationController
  before_filter :authenticate_user!
  #load_and_authorize_resource
  #layout "test", :only => :show

  def show
    @group = Group.find_by_name(params[:name])
    @all_stories = Group.get_all_stories(@group)
    @new_stories = Group.get_new_stories(@group)
    @top = Group.get_top_stories(@group)
    @trend = Group.get_trend_stories(@group)

    #@top = Micropost.find_with_reputation(:votes, :all, 
     # {:conditions => ["microposts.group_id = ?", @group.id], :order => 'votes desc'})
   # @trend = Micropost.find_with_reputation(:votes, :all, 
    #  {:conditions => ["microposts.group_id = ?", @group.id], :order => 'votes desc, created_at desc', :limit => 10})

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

  def square
    @group = Group.find_by_name(params[:name])
    @all_stories = Group.get_all_stories(@group)
    @new_stories = Group.get_new_stories(@group)
    @top = Group.get_top_stories(@group)
    @trend = Group.get_trend_stories(@group)
    respond_to do |format|
      format.js
    end
  end

  def list
    @group = Group.find_by_name(params[:name])
    @all_stories = Group.get_all_stories(@group)
    @new_stories = Group.get_new_stories(@group)
    @top = Group.get_top_stories(@group)
    @trend = Group.get_trend_stories(@group)
    respond_to do |format|
      format.js
    end
  end
end