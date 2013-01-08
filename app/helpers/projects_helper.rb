module ProjectsHelper
   def find_user_project(project)
      a = User.find(project)
      a.username
   end
   
   def find_user_image(project)
      a = User.find(project)
      b = "http://graph.facebook.com/#{a.uid}/picture?type=square"
   end
   
   def find_location(project)
      a = User.find(project)
      a.location
   end
end

