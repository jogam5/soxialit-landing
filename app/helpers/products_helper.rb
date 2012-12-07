module ProductsHelper
  
  def find_id
    a = Product.last
    b = a.id
    return b
  end
  
  
  def url_painting(product)
     if product.nil?
     else
        a = product.first
        return a.image_url
     end
  end
  
  def find_user (user)
     user = User.find_by_id(user)
     return user.username
  end
  
  def find_picture(user)
    user = User.find_by_id(user)
    return user.picture
  end
  
  def find_evaluation_id(evaluation)
     if current_user.evaluations.nil?
         a = evaluation.first
          b = a.source_id
          return b
     else
       
     end
  end
  
  def find_sizes(product)
     size = product.all
     sizes = []
     size.each do |x|
        sizes << x.name
     end
     sizes.join(' - ')
  end
  
  def total_price(price, envio)
     total = price + envio
     return number_to_currency(total)
  end
  
  def related_items(product)
     a = product.first
     return a.image_url
  end
end
