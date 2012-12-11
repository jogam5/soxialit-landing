module UsersHelper

	def find_title(evaluations)
	    b = Product.find(evaluations)
	    return b.title
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
	    b = Product.find(evaluations).user
	    return b.username
	end
end