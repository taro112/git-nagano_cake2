class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :item
    
    def subtotal
    item.with_tax_price * amount
    end
    
    def price
        item.with_tax_price
    end
    
    enum making_status: {  cannot_be_manufactured: 0, waiting_for_production: 1, in_production: 2, production_completed: 3 }
end
