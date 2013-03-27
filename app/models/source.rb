class Source < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name
  has_many :sourceships
  has_many :microposts, through: :sourceships

  def self.tokens(query)
      authors = where("name like ?", "%#{query}%")
      if authors.empty?
        [{id: "#{query}", name: "\"#{query}\""}]
      else
        authors
      end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end
end
