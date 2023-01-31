class ModeTransportsController < ApplicationController

    before_action :authenticate_user!, only:[:new, :create, :edit, :update, :show]

    before_action :set_mode_transport, only: [:show, :edit, :update]

    def index 
        @mode_transports = ModeTransport.all
    end

    def consult 
        @mode_transports_active = ModeTransport.active
        @mode_transports_disabled = ModeTransport.disabled
    end

    def details 
        @mode_transport = ModeTransport.find(params[:id])
    #    @prices = Price.where(mode_transport_id: params[:id])
        @prices = @mode_transport.prices
    #     @deadlines = Deadline.where(mode_transport_id: params[:id])
        @deadlines = @mode_transport.deadlines
    
    end

    def new
        @mode_transport = ModeTransport.new
    end

    def create
        @mode_transport = ModeTransport.new(mode_transport_params)
        if @mode_transport.save 
            redirect_to @mode_transport, notice: 'Modalidade cadastrada com sucesso !!!'
        else  
            flash.now[:notice] = 'Modalidade NÃO cadastrada !!!'
            render 'new'
        end
    end 

    def show 

    end

    def edit  

    end

    def update  
        if @mode_transport.update(mode_transport_params)
            redirect_to @mode_transport, notice: 'Modalidade atualizada com sucesso !!!'
        else
            flash.now[:notice] = 'Modalidade NÂO atualizada !!!'
            render 'edit'
        end

    end

    private

    def set_mode_transport 
        @mode_transport = ModeTransport.find(params[:id])
    end

    def mode_transport_params 
        params.require(:mode_transport).permit(:name, :minimum_distance, :maximum_distance, :minimum_weight,
                                                :maximum_weight, :delivery_fee, :status)
    end
end