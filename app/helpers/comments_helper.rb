module CommentsHelper
  
   def parse_url(text)
      #url_regexp = /http[s]?:\/\/\w/
      x = ""
      url_regexp = /(https?:\/\/([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)/
      x << text.scan(url_regexp).to_s
   end
   
end