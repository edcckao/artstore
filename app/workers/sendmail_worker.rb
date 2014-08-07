class SendmailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(order_id,mail_type)
    @order = Order.find(order_id)
    case mail_type
      when 'notify_order_placed'
        OrderMailer.notify_order_placed(@order).deliver
      when 'notify_card_charged'
        CardChargesMailer.notify_card_charged(@order).deliver
      when 'notify_order_shipped'
        ShipMailer.notify_order_shipped(@order).deliver
    end
  end
end