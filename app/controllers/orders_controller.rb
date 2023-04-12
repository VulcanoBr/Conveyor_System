class OrdersController < ApplicationController
    
    before_action :authenticate_user! 

    before_action :set_order, only: [:show, :edit, :update]

    def index 
        @orders = Order.where(user_id: current_user.id).pending
    end

    def new 
        @order = Order.new
    end

    def budget  
        @order = Order.find(params[:id])
        
        @result = ModeTransport.with_prices_and_deadlines_for_order(@order.distance, @order.weight)
    end

    def create
        @order = Order.new(order_params)
        @order.user_id = current_user.id
        if @order.save 
            redirect_to @order, notice: 'Ordem de Entrega criado com sucesso !!!'
        else  
            flash.now[:notice] = 'Ordem de Entrega NÃO criado !!!'
            render 'new'
        end
    end

    def show  
        
    end

    def edit 

    end

    def update 
        if @order.update(order_params)
            redirect_to @order, notice: 'Ordem de Entrega atualizada com sucesso !!!'
        else  
            flash.now[:notice] = 'Ordem de Entrega NÃO atualizada !!!'
            render 'edit'
        end
    end

    private

    def set_order
        @order = Order.find(params[:id])
    end

    def order_params 
        params.require(:order).permit(:code, :product_code, :description, :height, :width, :depth, :weight, 
                    :distance, :status, :user_id,
                    :sender_name, :sender_identification, :sender_email,
                    :sender_phone, :sender_address, :sender_city, :sender_state, :sender_zipcode,
                    :recipient_name, :recipient_identification, :recipient_email, :recipient_phone,
                    :recipient_address, :recipient_city, :recipient_state, :recipient_zipcode )
    end

end