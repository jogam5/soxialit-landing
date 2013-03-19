class PaypalPayment
  def initialize(pay)
    @pay = pay
  end
  
  def checkout_details
     #PayPal::Recurring.new(token: @pay.paypal_payment_token).checkout_details
    process :checkout_details
  end
  
  def checkout_url(options)
     process(:checkout, options).checkout_url
  end
  
  def make_recurring
    process :request_payment
    process :create_recurring_profile, period: :monthly, frequency: 1, start_at: Time.zone.now
  end
  
private

  def process(action, options = {})
    options = options.reverse_merge(
      token: @pay.paypal_payment_token,
      payer_id: @pay.paypal_customer_token,
      description: @pay.product.title,
      amount: @pay.product.price,
      currency: "MXN"
    )
    response = PayPal::Recurring.new(options).send(action)
    raise response.errors.inspect if response.errors.present?
    response
  end
end