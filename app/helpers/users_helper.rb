module UsersHelper

	def find_title(evaluations)
	    b = Product.find(evaluations)
	    return b.title
	end
	
	def find_product(evaluations)
	   product = Product.find(evaluations)
	   return product
	end

	def find_price(evaluations)
	    b = Product.find(evaluations)
	       return b.price
	end

	def find_foto(evaluations)
	    b = Product.find(evaluations)
	    return b.picture
	end

	def find_designer(evaluations)
	    b = Product.find(evaluations)
	    return b.brand
	end
	
	def find_user(evaluations)
	   b = Product.find(evaluations)
	   b.user_id
	end
	
	def find_micropost_title(evaluations)
	   a = Micropost.find(evaluations)
	   a.title
	end
	
	def find_micropost_image(evaluations)
	   a = Micropost.find(evaluations)
	   a.thumbnail
	end
	
	def find_micropost_url(evaluations)
	   a = Micropost.find(evaluations)
	   a.url
	end
	
	def find_micropost_username(evaluations)
	   a = User.find(evaluations)
	   a.username
	end
	
	def find_micropost_userimage(evaluations)
	   a = Micropost.find(evaluations)
	   b = User.find(a.user_id)
	   c = "http://graph.facebook.com/#{b.uid}/picture?type=square"
	   return c
	end
	
	def find_micropost_userurl(evaluations)
	   a = Micropost.find(evaluations)
	   b = User.find(a.user_id)
	   b.id
	end
	
	def find_micropost_description(evaluations)
	   a = Micropost.find(evaluations)
	   a.description
   end
end