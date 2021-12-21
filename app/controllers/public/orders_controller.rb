class Public::OrdersController < ApplicationController
    def new
        @order = Order.new
        @addresses = current_customer.addresses
    end
    
    def verification
        @order = Order.new(order_params)
        @sum = 0
        @order.set_shipping_cost
        @cart_items = current_customer.cart_items
        if  params[:order][:select_address] == "1"
            @order.name = current_customer.last_name + current_customer.first_name
            @order.postal_code = current_customer.postal_code
            @order.address = current_customer.address
             
            

        elsif params[:order][:select_address] == "2"
            address = Address.find(params[:order][:concatenate_address])
            @order.name = address.name
            @order.postal_code = address.postal_code
            @order.address = address.address
            
        elsif params[:order][:select_address] == "3"
           
        end
        
        
        
        
    end
    
    def create
        @order = Order.new(order_params)
        @order.customer_id = current_customer.id
        if @order.save 
            cart_items = current_customer.cart_items
            cart_items.each do |cart_item|
                @order_detail = OrderDetail.new
                @order_detail.order_id = @order.id
                @order_detail.item_id = cart_item.item_id
                @order_detail.price = cart_item.item.price
                @order_detail.amount = cart_item.amount
                @order_detail.save
            end
            current_customer.cart_items.destroy_all
        end
        redirect_to orders_thank_path
    end
    
    def index
         @orders = current_customer.orders
    end
    
    def show
        @order = Order.find(params[:id])
        @order_details = @order.order_details
        @sum = 0
        @order_details.each do |order_detail|
         @sum += order_detail.subtotal
    
        end
    end
    
    def thank
    end
    
   


    
    private

    def order_params
        params.require(:order).permit(:total_payment, :name,  :shipping_cost, :address, :postal_code, :payment_method, :customer_id, :status)
    end
end
