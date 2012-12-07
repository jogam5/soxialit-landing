class Size < ActiveRecord::Base
  attr_accessible :name, :product_id
  belongs_to :product
  
  
    def self.tokens(query)
      authors = where("name like ?", "%#{query}%")
      if authors.empty?
        [{id: "<<<#{query}>>>", name: "\"#{query}\""}]
      else
        authors
      end
    end

    def self.ids_from_tokens(tokens)
      tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
      tokens.split(',')
    end
end
