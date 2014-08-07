class OrderShippingService
  def initialize(order)
    @order = order
  end
 
  def ship_order!
    # Reserve for interactions with logistics

    @order.ship!
    SendmailWorker.perform_async(@order.id, 'notify_order_shipped')
  end
end
