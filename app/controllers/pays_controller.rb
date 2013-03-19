class PaysController < ApplicationController
  def new
    product = Product.find(params[:product_id])
     @pay = product.pays.build
         if params[:PayerID]
            @pay.paypal_customer_token = params[:PayerID]
            @pay.paypal_payment_token = params[:token]
            @pay.email = @pay.paypal.checkout_details.email
            logger.debug "paypal email es:   #{@pay.email}\n\n\n\n\n\n"
          end
  end

  def create
    @pay = Pay.new(params[:pay])
    product = Product.find(@pay.product_id)
    product.pays.create(email:@pay.email, paypal_recurring_profile_token: @pay.paypal_recurring_profile_token, paypal_customer_token: @pay.paypal_customer_token)
    respond_to do |format|
       if @pay.save_with_payment
       elsif user_signed_in?
         format.html {redirect_to current_user, notice: 'Gracias por tu compra, en un momento te enviaremos informacion'}
       else
          format.html {redirect_to products_path, notice: 'Gracias por tu compra, en un momento te enviaremos informacion'}
       end
   end
  end

  def show
    @pay = Pay.find(params[:id])
  end
=begin  
  def paypal_checkout
    product = Product.find(params[:product_id])
    pay = product.pays.build
    redirect_to pay.paypal.checkout_url(
      return_url: product_url(:product_id => product_id),
      cancel_url: products_url
    )
  end
=end
  def paypal_checkout
          product = Product.find(params[:product_id])
          ppr = PayPal::Recurring.new(
           return_url: product_url(product),
           cancel_url: products_url,
           description: product.title,
           amount: product.price,
           currency: "MXN"
          )
          response = ppr.checkout
          if response.valid?
            redirect_to response.checkout_url
          else
            raise response.errors.inspect
         end
     end
     
end