class CardChargingService
  def initialize(order)
    @order = order
  end
 
  def charge_card!
    @order.set_payment_with!("credit_card")
    @order.make_payment!
    SendmailWorker.perform_async(@order.id, 'notify_card_charged')
  end
end
