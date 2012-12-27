class PartnersController < ApplicationController
    def index
       @partner = Partner.new
       respond_to do |format|
         format.html # new.html.erb
       end
     end

     def create
       @partner = current_user.partners.build(params[:partner])
       respond_to do |format|
         if @partner.save
           format.html { redirect_to current_user, notice: 'Gracias, en breve nos pondremos en contacto contigo.' }
         else
           format.html { render action: "index" }
         end
       end
     end
end
