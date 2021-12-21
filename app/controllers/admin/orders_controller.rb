class Admin::OrdersController < ApplicationController
    def show
        @order = Order.find(params[:id])
        @order_details = @order.order_details
        @sum = 0
        @order_details.each do |order_detail|
         @sum += order_detail.subtotal
    
        end
    end
    
    def update
         @order = Order.find(params[:id])
         @order.update(order_params)
         redirect_to admin_order_path
    end
    
    private

    def order_params
    
    params.require(:order).permit(:address, :name, :postal_code, :shipping_cost, :total_payment, :payment_method, :status)
    end
    
end
