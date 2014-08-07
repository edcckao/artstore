class OrderPlacingService
  def initialize(cart,order)
    @order = order
    @cart = cart
  end
 
  def place_order!
    @order.build_item_cache_from_cart(@cart)
    @order.calculate_total!(@cart)
    @cart.clear!
    SendmailWorker.perform_async(@order.id, 'notify_order_placed')
  end
end
