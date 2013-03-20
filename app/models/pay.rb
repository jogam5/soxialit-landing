class Pay < ActiveRecord::Base
  attr_accessible :email, :product_id
  attr_accessible :paypal_customer_token, :paypal_payment_token, :paypal_recurring_profile_token
  belongs_to :product
  validates_presence_of :product_id
  validates_presence_of :email

  attr_accessor :paypal_payment_token
  #attr_accessor :paypal_customer_token
  

    def save_with_payment
      if valid?
        if paypal_payment_token.present?
            ppr = PayPal::Recurring.new(
                 token: paypal_payment_token,
                 payer_id: paypal_customer_token,
                 description: product.title,
                 amount: product.price,
                 currency: "MXN"
                 )
              response = ppr.request_payment
      end
    end

    def paypal
      PaypalPayment.new(self)
    end

    def save_with_paypal_payment
     ppr = PayPal::Recurring.new(
         token: paypal_payment_token,
         payer_id: paypal_customer_token,
         description: @pay.product.title,
         amount: @pay.product.price,
         currency: "MXN"
         )
      response = ppr.request_payment
      #self.paypal_recurring_profile_token = response.profile_id
      #save!
    end

    def payment_provided?
      paypal_payment_token.present?
    end
  end
end
