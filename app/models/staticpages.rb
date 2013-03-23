class StaticPages < ActiveRecord::Base
  attr_accessible :source_tokens
  attr_reader :source_tokens

  def source_tokens=(ids)
     self.source_ids = ids.split(",")
  end
  
end 
