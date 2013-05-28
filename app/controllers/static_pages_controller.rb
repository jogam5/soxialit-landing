class StaticPagesController < ApplicationController
  #layout "black", :only => :black

  #layout "feed", :only => :home
  #layout "test", :only => :feed
  layout "index", :only => :index
    layout "black", :only => :black


  def home
    @stats = Rails.cache.stats.first.last unless Rails.env.development?
  	@comment = Comment.new
    @micropost = Micropost.new
    @last = Micropost.last
  	if user_signed_in?
  		@feed_items = User.feed_cached(current_user)  if Rails.env.development?
      #@feed_items = current_user.feed 
      @feed_items = User.feed_cached(current_user) if Rails.env.production?
  	else
  	  @feed_items = User.feed_cached(User.find(1)) if Rails.env.production?
      @feed_items = User.feed_cached(User.find(47)) if Rails.env.development?
      #@feed_items = User.first.feed 
  	end
  end

  def preview
    @Micropost = Micropost.find(params[:micropost])
  end

  def about
    @users = User.limit(6)
  end
  
  def soxialit
    respond_to do |format|
      format.js
    end
  end

  def faq
    respond_to do |format|
      format.js
    end
  end
  
  def privacy
    respond_to do |format|
      format.js
    end
  end

   def team
    respond_to do |format|
      format.js
    end
  end
  
  def term
    respond_to do |format|
      format.js
    end
  end

  def sell
    respond_to do |format|
      format.js
    end
  end

  def buy
    respond_to do |format|
      format.js
    end
  end

  def examples
    respond_to do |format|
      format.js
    end
  end

  def guides
    respond_to do |format|
      format.js
    end
  end

  def term
    respond_to do |format|
      format.js
    end
  end
  
  def payment
  end

  def registro
    @users = User.all
    @fotografos = []
    @users.each do |user|
      if user.roles.first.name == "fotografo"
        @fotografos << user
      end
    end
  end
  
  def demo
    @products = [Product.find(257),Product.find(258), Product.find(259), Product.find(260), Product.find(261), Product.find(262)]
  end

  def items
    respond_to do |format|
      format.js
    end
  end

  def biografia
    respond_to do |format|
      format.js
    end
  end
  
  def men_heute
    @products = [Product.find(230),Product.find(231), Product.find(232), Product.find(241), Product.find(242), Product.find(243)]
  end
  
  def modal_item
     @product = Product.find(params[:product_id])
  end
  
  def arbol_viento
   @products = [Product.find(233), Product.find(234), Product.find(235)]
  end
  
  def modal_post
    @micropost = Micropost.new
    @microposts = Micropost.all
    @groups = Group.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @microposts.tokens(params[:q]) }
      format.js
    end
  end

  def las7depauline
     @microposts = [Micropost.find(1182), Micropost.find(1183), Micropost.find(1174), Micropost.find(1181), Micropost.find(1180), Micropost.find(1184), Micropost.find(1179), Micropost.find(1070), Micropost.find(1074),Micropost.find(1055),Micropost.find(1051),Micropost.find(1050),Micropost.find(1049),Micropost.find(1047), Micropost.find(1001), Micropost.find(1054), Micropost.find(1053), Micropost.find(1052), Micropost.find(1048), Micropost.find(1021), Micropost.find(1000), Micropost.find(921), Micropost.find(920), Micropost.find(919),Micropost.find(918),Micropost.find(917),Micropost.find(914),Micropost.find(879),Micropost.find(868),Micropost.find(862),Micropost.find(861),Micropost.find(860),Micropost.find(859),Micropost.find(820),Micropost.find(814),Micropost.find(804),Micropost.find(797),Micropost.find(796),Micropost.find(757),Micropost.find(756),Micropost.find(755), Micropost.find(750), Micropost.find(694), Micropost.find(693), Micropost.find(691), Micropost.find(685), Micropost.find(673), Micropost.find(671), Micropost.find(588), Micropost.find(587), Micropost.find(585), Micropost.find(586), Micropost.find(553), Micropost.find(543), Micropost.find(541), Micropost.find(539), Micropost.find(528), Micropost.find(527), Micropost.find(518), Micropost.find(513), Micropost.find(484), Micropost.find(483), Micropost.find(482), Micropost.find(476), Micropost.find(467), Micropost.find(463), Micropost.find(459), Micropost.find(456), Micropost.find(465), Micropost.find(466), Micropost.find(460), Micropost.find(400) ,Micropost.find(401), Micropost.find(402) ,Micropost.find(403), Micropost.find(404)]
     @newsletter = @microposts.paginate(:page => params[:page], :per_page => 7)
  end

  def fivehundred
  end

  def feed
    @stories = current_user.groups.includes(:microposts)
    @stories_top = Micropost.joins(:group => :users).where(:users => {id: current_user.id})
    @top = @stories_top.paginate(:page => params[:page], :per_page => 50).sort! {|mp1, mp2| mp2.reputation(mp2) <=> mp1.reputation(mp1) }
    @stories_new = Micropost.joins(:group => :users).where(:users => {id: current_user.id}).order("created_at DESC")
    @new = @stories_new.paginate(:page => params[:page], :per_page => 50)
    @stories_trend = Micropost.joins(:group => :users).where(:users => {id: current_user.id}).order("created_at DESC").limit(50)
    @trend = @stories_trend.paginate(:page => params[:page], :per_page => 50).sort! {|mp1, mp2| mp2.reputation(mp2) <=> mp1.reputation(mp1) }
  end

  def story
    @micropost = Micropost.new
  end

  def scrap
    require 'embedly'
    require 'json'
    embedly_api = Embedly::API.new :key => '80abb9f8804a4cad90d3f21d33b49037',
            :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'

    obj = embedly_api.oembed(:url => 'http://soxialit.com', :maxwidth => 500,
                :maxheight => 500)

    #puts obj[0].marshal_dump
    json_obj = JSON.pretty_generate(obj[0].marshal_dump)
    puts json_obj
   end

  def index
    @group = Group.find(1)
    @all_stories = Group.get_all_stories(@group)
    @new_stories = Group.get_new_stories(@group)
    @top = Micropost.find_with_reputation(:votes, :all, 
      {:conditions => ["microposts.group_id = ?", @group.id], :order => 'votes desc'})
    @trend = Micropost.find_with_reputation(:votes, :all, 
      {:conditions => ["microposts.group_id = ?", @group.id], :order => 'votes desc, created_at desc', :limit => 10})

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  def black
    @group = Group.find(2)
    @all_stories = Group.get_all_stories(@group)
    @new_stories = Group.get_new_stories(@group)
    @top = Micropost.find_with_reputation(:votes, :all, 
      {:conditions => ["microposts.group_id = ?", @group.id], :order => 'votes desc'})
    @trend = Micropost.find_with_reputation(:votes, :all, 
      {:conditions => ["microposts.group_id = ?", @group.id], :order => 'votes desc, created_at desc', :limit => 10})

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end
end