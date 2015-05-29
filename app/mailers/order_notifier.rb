class OrderNotifier < ApplicationMailer

  # Values that are common to all mail calls in the mailer can be set as defaults by simply calling default
  default from: 'Nile Trading Co <info@niletradingco.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #

  # Added order as an argument to the method-received call, and added code to copy the parameter passed into an
  # instance variable, and update the call to mail() specifying where to send the email and what subject line to use.
  def received(order)
    @order = order

    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #

  # Added order as an argument to the method-received call, and added code to copy the parameter passed into an
  # instance variable, and update the call to mail() specifying where to send the email and what subject line to use.
  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end
end
