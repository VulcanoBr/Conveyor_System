class PricesController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    before_action :set_price, only: [:edit, :update, :destroy]

    def index 
        @mode_transport = ModeTransport.find(params[:mode_transport_id])
        @prices = Price.where(mode_transport_id: params[:mode_transport_id])
    end

    def new 
        @mode_transport = ModeTransport.find(params[:mode_transport_id])
        @price = Price.new
    end

    def create
        @price = Price.new(price_params)
        @price.mode_transport_id = params[:mode_transport_id]
        if @price.save 
            redirect_to mode_transport_prices_path(mode_transport_id: @price.mode_transport_id), 
                            notice: 'Preço cadastrado com sucesso !!!'
        else  
            flash.now[:notice] = 'Preço NÃO cadastrado !!!'
            @mode_transport = ModeTransport.find(params[:mode_transport_id])
            render 'new'
           # redirect_to new_mode_transport_price_path(mode_transport_id: params[:mode_transport_id])
        end
    end

    def edit 
        @mode_transport = ModeTransport.find(params[:mode_transport_id])
    end

    def update
        if @price.update(price_params)
            redirect_to mode_transport_prices_path(mode_transport_id: @price.mode_transport_id), 
                    notice: 'Preço atualizado com sucesso !!!'
        else  
            flash.now[:notice] = 'Preço NÃO atualizado !!!'
            @mode_transport = ModeTransport.find(params[:mode_transport_id])
            render 'edit'
        end
    end

    def destroy
        @mode_transport = ModeTransport.find(params[:mode_transport_id])
        @price.destroy
        
        redirect_to mode_transport_prices_path(mode_transport_id: @mode_transport.id), notice: 'Prazo removido com sucesso !!!'
    end

    private

    def set_price  
        @price = Price.find(params[:id])
    end

    def price_params 
        params.require(:price).permit(:start_weight, :final_weight, :km_price, :mode_transport_id)
    end

end