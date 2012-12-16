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
	
end