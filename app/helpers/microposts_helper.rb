module MicropostsHelper
   def find_micropost_imagefile(id)
	   a = Micropost.find(id)
	   b = User.find(a.user_id)
	   c = b.picture_url(:profile)
	   return c
	end
	
	def find_micropost_userimage(id)
	   a = Micropost.find(id)
	   b = User.find(a.user_id)
	   c = "http://graph.facebook.com/#{b.uid}/picture?type=square"
	   return c
	end
	
	def find_micropost_nickname(id)
	   a = Micropost.find(id)
	   b = User.find(a.user_id)
	   b.nickname
   end
	
   def tagging(tag_list)
   		tags = []
   		tags.each do |tokens|
   			tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    		tags << tokens.split(',')
    	end
    	return tags
   	end
end
