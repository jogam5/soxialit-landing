module ProductsHelper
   
   def find_evaluation_id(evaluation)
       if current_user.evaluations.nil?
           a = evaluation.first
           b = a.source_id
           return b
       else
         
       end
    end
    
end
