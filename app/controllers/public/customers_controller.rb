class Public::CustomersController < ApplicationController
    def my_page 
        @customer = current_customer
        
    end
    
    def unsubscribe
        @customer = current_customer
    end
    
    def withdrawal
        @customer = current_customer
        @customer.update(is_deleted: true)
        reset_session
        redirect_to root_path
    end
    
    def edit
        @customer = current_customer
    end
    
    def update
        customer = current_customer
        customer.update(customer_params)
        redirect_to customers_my_page_path
    end
    
    private

    def customer_params
    params.require(:customer).permit(:first_name, :first_name_kana, :last_name, :last_name_kana, :postal_code, :address, :telephone_number, :email)
    end
end
