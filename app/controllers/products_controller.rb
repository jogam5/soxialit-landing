class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :tallas, :comprar, :mercadopago_checkout, :paypal_checkout, :PayerID, :envio_df, :envio]
  load_and_authorize_resource
  layout "products_index", :only => [:index]
  layout "show_product", :only => [:show]
   
    def status
      Product.update_all({:status => true}, {:id => params[:status_ids]})
      a = []
      b = params[:status_ids]
      b.each do |id|
         logger.debug "producto id: #{id}"
         b = Product.find(id)
         logger.debug "producto: #{b}"
      end
      Product.delay.publish_product_facebook(b) unless b.user.fb == false
      redirect_to products_path
    end
    
    def products_all
      @products = avoid_nil(Product.all)
      @users = User.all
    end
    
    def index  
     if params[:tag]
         @products = product_ok(Product.tagged_with(params[:tag]))   
         @users = User.all
     else
         @products = product_ok(Product.all)
         @products.sort_by!(&:reputations)
         @tags = Tag.where("name like ?", "%#{params[:q]}%")
         @users = User.all
      end
     respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @products.map(&:attributes) }  
        format.js
      end
    end
    
    def product_ok(items)
        products = []
        items.each do |item|
           if item.status == true
              products << item
           end
         end
         return products
     end
    

    def avoid_nil(products)
       items = []
       products.each do |product|
          if product.title.blank? && product.description.blank?
          else
             items << product
          end
        end 
        return items
    end
    # GET /products/1
    # GET /products/1.json
    def show
        @product = Product.find_by_id(params[:id])
        @tags = Product.tagged_with([@product.tag_list], :any => true)
        id = @product.user_id
         @user = User.find(id)
         @users = User.all
         @products = avoid_nil(@user.products.all)
         user_cp = find_user_product(@product)
         @pay = @product.pays.build
         if params[:PayerID]
           logger.debug "PayPal #{params[:PayerID]}\n\n\n\n\n\n"
           @pay.paypal_customer_token = params[:PayerID]
           @pay.paypal_payment_token = params[:token]
           @pay.email = PayPal::Recurring.new(token: params[:token]).checkout_details.email
         end

         if signed_in?
            if current_user.direction.nil? || user_cp.nil?
            else
=begin              
               user_product_cp = find_user_product(@product)
               current_user_cp = current_user.direction.zipcode
               logger.debug "#{user_product_cp}\n\n\n\n\n\n"
               logger.debug "#{current_user_cp}\n\n\n\n\n\n"
               if @product.tipo_envio == "sobre"
                   url = "http://rastreo2.estafeta.com:7001/Tarificador/admin/TarificadorAction.do?dispatch=doGetTarifas&cCodPosOri=#{user_product_cp}&cCodPosDes=#{current_user_cp}&cTipoEnvio=#{@product.tipo_envio}&cIdioma=Esp"
                else
                   url = "http://rastreo2.estafeta.com:7001/Tarificador/admin/TarificadorAction.do?dispatch=doGetTarifas&cCodPosOri=#{user_product_cp}&cCodPosDes=#{current_user_cp}&cTipoEnvio=#{@product.tipo_envio}&cIdioma=Esp&nPeso=#{@product.peso}&nLargo=#{@product.largo}&nAncho=#{@product.ancho}&nAlto=#{@product.alto}"
               end
               logger.debug "#{url}\n\n\n\n\n\n"
               require 'net/http'
               require 'rubygems'
               require 'nokogiri'
               require 'open-uri'

                doc = Nokogiri::HTML(open(url))
                @dias = []
                doc.css(':nth-child(6) .style5 strong , :nth-child(7) strong, :nth-child(8) strong').each do |node|
                     @dias.push(node.text)
                end 
                logger.debug "#{@dias}\n\n\n\n\n\n"

                @tarifas = []
                   doc.css(':nth-child(6) td:nth-child(8) , :nth-child(7) :nth-child(8), :nth-child(8) td:nth-child(8)').each do |node|
                   @tarifas.push(node.text)
                end
                logger.debug "#{@tarifas}\n\n\n\n\n\n"
=end         

            end
         end
         respond_to do |format|
           format.html # show.html.erb
           format.json { render json: @product }
           format.js
         end
    end
    
    def new
      @product = current_user.products.create
      @product.activities.create(:user_id => current_user.id, :action => "create")
      Activity.expire_feed_cache(@product.user)

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @product }
      end
    end

    # GET /products/1/edit

    def edit
      @product = Product.find(params[:id])
      @paintings = @product.paintings.all
      @tags = @product.tags.all

        respond_to do |format|
            format.html    
            format.json 
            format.js 
        end
    end

    def create
      @product = Product.find(params[:product_id])
      @paintings = @product.paintings.all
      if @product.paintings.any?
         if params[:position].nil?
         else
            painting = Painting.find(params[:position])
            @product.update_attribute(:picture, painting.image_url(:picture_300).to_s)
         end
      end
      respond_to do |format|
      if @product.update_attributes(params[:product])
         format.html { redirect_to @product, notice: 'El producto fue creado correctamente, en menos de 12 hrs. sera publicado' }
         format.json { render json: @product, status: :created, location: @product }
         format.js
        else
          format.html { render action: "edit" }
          format.json { render json: @product.errors, status: :unprocessable_entity }
          format.js
        end
      end
    end


    def update
      @product = Product.find(params[:id])
      if @product.paintings.any?
         if params[:position].nil?
         else
            painting = Painting.find(params[:position])
            @product.update_attribute(:picture, painting.image_url(:picture_300).to_s)
         end
       end
       respond_to do |format|
        if @product.update_attributes(params[:product])
          format.html { redirect_to @product, notice: 'Producto editado correctamente' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

     def destroy
      @product = Product.find(params[:id])
      @product.destroy
      respond_to do |format|
        format.html { redirect_to current_user, notice: 'El producto fue eliminado.' }
        format.json { head :no_content }
      end
    end
=begin
    def paypal_checkout
           product = Product.find(params[:product_id])
           ppr = PayPal::Recurring.new(
            return_url: product_url(product),
            cancel_url: products_url,
            description: product.title,
            amount: product.total_price,
            currency: "MXN"
           )
           response = ppr.checkout
           if response.valid?
             redirect_to response.checkout_url
           else
             raise response.errors.inspect
          end
      end
=end
    def envio_df 
     @product = Product.find(params[:id])
     if user_signed_in?
        user = current_user.id
     else 
        user = "nil"
     end
     @product.ships.create(:ship_selected => params[:envio], :user_id => user, :ship_name => params[:id])
     @product.total_price = (@product.price + @product.ships.last.ship_selected).to_i
     @product.save
   end

   def tallas
      @product = Product.find(params[:product_id])
   end
   
   def comprar_login
      @product = Product.find(params[:product_id])
   end

    def comprar
       @product = Product.find(params[:product_id])
      # @product.ships.build
       @user = User.find(@product.user_id)
      # @direction = Direction.new
       #if user_signed_in?
        #  @address = current_user.direction
       #end
       #user_cp = find_user_product(@product)
       #if user_signed_in?
        # if current_user.direction.nil? || user_cp.nil?
         #else
          #   user_product_cp = find_user_product(@product)
           #  current_user_cp = current_user.direction.zipcode
            # logger.debug "#{user_product_cp}\n\n\n\n\n\n"
             #logger.debug "#{current_user_cp}\n\n\n\n\n\n"
             #if @product.tipo_envio == "sobre"
              #  url = "http://rastreo2.estafeta.com:7001/Tarificador/admin/TarificadorAction.do?dispatch=doGetTarifas&cCodPosOri=#{user_product_cp}&cCodPosDes=#{current_user_cp}&cTipoEnvio=#{@product.tipo_envio}&cIdioma=Esp"
            # else
             #   url = "http://rastreo2.estafeta.com:7001/Tarificador/admin/TarificadorAction.do?dispatch=doGetTarifas&cCodPosOri=#{user_product_cp}&cCodPosDes=#{current_user_cp}&cTipoEnvio=#{@product.tipo_envio}&cIdioma=Esp&nPeso=#{@product.peso}&nLargo=#{@product.largo}&nAncho=#{@product.ancho}&nAlto=#{@product.alto}"
            # end
             #   logger.debug "#{url}\n\n\n\n\n\n"
              #  require 'net/http'
               # require 'rubygems'
                #require 'nokogiri'
                #require 'open-uri'

             #   doc = Nokogiri::HTML(open(url))
              #  @dias = []
               # doc.css(':nth-child(6) .style5 strong , :nth-child(7) strong, :nth-child(8) strong').each do |node|
                #     @dias.push(node.text)
               # end 

           #  @tarifas = []
            #    doc.css(':nth-child(6) td:nth-child(8) , :nth-child(7) :nth-child(8), :nth-child(8) td:nth-child(8)').each do |node|
             #   @tarifas.push(node.text)
            # end
         #end
      #end
    end

    def envio
        @product = Product.find(params[:product_id])
         respond_to do |format|
            format.js
          end
     end

    def vote
      value = params[:type] == "up" ? 1 : -1
      @product = Product.find(params[:id])
      @product.add_or_update_evaluation(:votes, value, current_user)
      @product.activities.create(:user_id => current_user.id, :action => "like")
      @user = User.find(@product.user_id)
      Product.delay.publish_product_like_facebook(@product, current_user) unless current_user.fb == false
      if !@user.notification.nil?
         if @user.notification.lov_item == true
            UserMailer.lov_item(@user ,current_user, @product ).deliver
         end
      end
      respond_to do |format|
        format.js
        format.xml
      end
    end

    def products_as_json(product)
       if user_signed_in?
          username = current_user.username
          surname = current_user.username
          email = current_user.email
       else
          username = "Usuario Nuevo"
          surname = "Usuario Nuevo"
          email = "email nuevo"
      end
          
       data = {
         "external_reference" => "ARTICLE-ID-#{product.id}",
         "items" => [
           {
             "id" => product.id,
             "title" => product.title,
             "description" => product.description,
             "quantity" => 1,
             "unit_price" => product.price.to_i,
             "currency_id" => "MEX",
             "picture_url" => "http://i1266.photobucket.com/albums/jj523/JulioAhuactzin/Safari3_zpsb24612a1.png"
           }
         ],
         "payer" => {
             "name"=> username,
             "surname"=> surname,
             "email"=> email
           },
         "back_urls"=> {
           "pending"=> "https://www.soxialit.com",
           "success"=> "http://www.soxialit.com/",
           "failure"=> "http://www.soxialit.com/"
         }
       }
       return data
      # logger.debug "#{json}\n\n\n\n\n\n"
    end

    # your_view.html.erb

    def mercadopago_checkout
        product = Product.find(params[:product_id])
        test = products_as_json(product)
        mp_data = product.mercadopago_url(test)
        result = JSON.parse(mp_data.to_json)
        initpoint = result["init_point"]
        redirect_to initpoint
    end
    
    def tags
      query = params[:q]
      if query[-1,1] == " "
         query = query.gsub(" ", "")
         Tag.find_or_create_by_name(query)
      end
      @tags = ActsAsTaggableOn::Tag.all
      @tags = @tags.select { |v| v.name =~ /#{query}/i }
         respond_to do |format|
            format.json { render :json => @tags.collect{|t| {:id => t.name, :name => t.name }}}
         end
      end   

      def find_user_product(product)
           id_user = product.user_id
           user = User.find(id_user)
           if user.direction.nil?
           else
           user.direction.zipcode
        end
      end    
end
