class OrderMailer < ActionMailer::Base
  MANAGER_EMAIL = "zakaz@lektravy.com"
  MANAGERS = ["mktsz@mail.ru", "temporaryvkmail@gmail.com"]
  default from: MANAGER_EMAIL

  def order_created_customer_notify(order)
    @order = order
    mail to: order.customer.email, subject: t('email.order_created_title', number: order.id)
  end

  def order_created_manager_notify(order)
    @order = order
    mail to: MANAGERS, subject: t('email.order_created_mgr_title', number: order.id, full_cost: order.full_cost)
  end
end
