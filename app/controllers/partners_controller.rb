class PartnersController < ApplicationController
    def index
       @partner = Partner.new
       respond_to do |format|
         format.html # new.html.erb
       end
     end

     def create
       if user_signed_in?
          @partner = current_user.partners.build(params[:partner])
       else
          @partner = Partner.create(params[:partner])
       end
       respond_to do |format|
         if @partner.save
            if user_signed_in?
               format.html { redirect_to current_user, notice: 'Gracias, en breve nos pondremos en contacto contigo.' }
            else
               format.html { redirect_to root_path, notice: 'Gracias, en breve nos pondremos en contacto contigo.' }
            end
         else
           format.html { render action: "index" }
         end
       end
     end
end
