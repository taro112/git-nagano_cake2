class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_details
    
    def set_shipping_cost
        self.shipping_cost = 800
    end
    
    
    
    
    def subtotal
    item.with_tax_price * amount
    end
    
    enum status: {  waiting_for_deposit: 0, payment_confirmation: 1, in_production: 2, preparing_to_ship: 3, sent: 4 }
    
    enum payment_method: { credit_card: 0, transfer: 1 }
end
