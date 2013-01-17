class DirectionsController < ApplicationController
  
  def new
    Direction.new
  end

  def create
    @direction = current_user.build_direction(params[:direction])
    @direction.save!
    if !@direction.product_id.nil?
       logger.debug "product id: #{@direction.product_id}"
       @product = Product.find(@direction.product_id)
        user_cp = find_user_product(@product)
        logger.debug "user cp: #{user_cp}"
        
        if user_signed_in?
          if current_user.direction.nil? || user_cp.nil?
          else
              user_product_cp = find_user_product(@product)
              current_user_cp = current_user.direction.zipcode
              logger.debug "User cp: #{user_product_cp}\n\n\n\n\n\n"
              logger.debug "current_user cp: #{current_user_cp}\n\n\n\n\n\n"
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

                 @tarifas = []
                  doc.css(':nth-child(6) td:nth-child(8) , :nth-child(7) :nth-child(8), :nth-child(8) td:nth-child(8)').each do |node|
                  @tarifas.push(node.text)
                 end
            end
         end
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