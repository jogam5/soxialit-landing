module StaticPagesHelper
   def find_evaluation_id(evaluation)
        if current_user.evaluations.nil?
            a = evaluation.first
             b = a.target_id
             return b
        else
           
        end
     end
end