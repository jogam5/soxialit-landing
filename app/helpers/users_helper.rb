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
	   a = User.find(evaluations)
	   b = "http://graph.facebook.com/#{a.uid}/picture?type=square"
	   return b
	end
	
	def find_micropost_userurl(evaluations)
	   a = User.find(evaluations)
	   a.id
	end
end