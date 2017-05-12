class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def receipt_email(order)
    @items = LineItem.where(order_id: order.id)
    mail(to: order.email, subject: "Thank you for your recent order #{order.id}")
  end
end
