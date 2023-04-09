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
        
        @result = ModeTransport.joins(:prices, :deadlines)
            .where("mode_transports.minimum_distance <= #{@order.distance} 
                    AND mode_transports.maximum_distance >= #{@order.distance} 
                    AND mode_transports.minimum_weight <= #{@order.weight}
                    AND mode_transports.maximum_weight >= #{@order.weight} 
                    AND prices.start_weight <= #{@order.weight} 
                    AND prices.final_weight >= #{@order.weight} 
                    AND deadlines.start_distance <= #{@order.distance} 
                    AND deadlines.final_distance >= #{@order.distance} ")
            .select("mode_transports.id, mode_transports.delivery_fee, 
                     mode_transports.name, prices.km_price, deadlines.deadline_hours")
      
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