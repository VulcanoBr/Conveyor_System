class DeadlinesController < ApplicationController


    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    before_action :set_deadline, only: [:edit, :update, :destroy]

    def index 
        @mode_transport = ModeTransport.find(params[:mode_transport_id])
        @deadlines = Deadline.where(mode_transport_id: params[:mode_transport_id])
    end

    def new 
        @mode_transport = ModeTransport.find(params[:mode_transport_id])
        @deadline = Deadline.new
    end

    def create
        @deadline = Deadline.new(deadline_params)
        @deadline.mode_transport_id = params[:mode_transport_id]
        if @deadline.save 
            redirect_to mode_transport_deadlines_path(mode_transport_id: @deadline.mode_transport_id), 
                            notice: 'Prazo cadastrado com sucesso !!!'
        else  
            flash.now[:notice] = 'Prazo NÃO cadastrado !!!'
            @mode_transport = ModeTransport.find(params[:mode_transport_id])
            render 'new'
           # redirect_to new_mode_transport_deadline_path(mode_transport_id: params[:mode_transport_id])
        end
    end

    def edit 
        @mode_transport = ModeTransport.find(params[:mode_transport_id])
    end

    def update
        if @deadline.update(deadline_params)
            redirect_to mode_transport_deadlines_path(mode_transport_id: @deadline.mode_transport_id), 
                    notice: 'Prazo atualizado com sucesso !!!'
        else  
            flash.now[:notice] = 'Prazo NÃO atualizado !!!'
            @mode_transport = ModeTransport.find(params[:mode_transport_id])
            render 'edit'
        end
    end

    def destroy
        @mode_transport = ModeTransport.find(params[:mode_transport_id])
        @deadline.destroy
        
        redirect_to mode_transport_deadlines_path(mode_transport_id: @mode_transport.id), notice: 'Prazo removido com sucesso !!!'
    end

    private

    def set_deadline  
        @deadline = Deadline.find(params[:id])
    end

    def deadline_params 
        params.require(:deadline).permit(:start_distance, :final_distance, :deadline_hours, :mode_transport_id)
    end
end