class VehiclesController < ApplicationController

    before_action :authenticate_user!, only:[:new, :create, :show, :edit, :update, :destroy, :maintenance, :operation]

    before_action :set_vehicle, only: [:show, :edit, :update, :maintenance, :operation, :indelivery]

    before_action :set_category, only: [:new, :create, :edit, :update]

    def index
        @pesq_veic = params[:query]
        if params[:query].present?
            @vehicles = Vehicle.where("nameplate LIKE ?", "%#{params[:query]}%")
        else
            @vehicles = Vehicle.all
        end
    end

    def list  
        @pesq_veic = params[:query]
        if params[:query].present?
            @vehicles = Vehicle.where("nameplate LIKE ?", "%#{params[:query]}%")
        else
            @vehicles = Vehicle.all
        end
    end

    def new 
        @vehicle = Vehicle.new
    end

    def show 

    end

    def create 
        @vehicle = Vehicle.new(vehicle_params)
        if @vehicle.save
            redirect_to @vehicle, notice: 'Veiculo cadastrado com sucesso !!!'
        else 
            flash.now[:notice] = 'Veiculo NÃO cadastrado !!!'
            render 'new'
        end

    end

    def edit 

    end

    def update 
        if @vehicle.update(vehicle_params)
            redirect_to @vehicle, notice: 'Veiculo atualizado com sucesso !!!'
        else  
            flash.now[:notice] = 'Veiculo NÃO atualizado !!!'
            render 'edit'
        end
    end

    def maintenance
        @vehicle.under_maintenance!
        redirect_to @vehicle, notice: 'Veiculo passado para Manutenção com sucesso !!!'
    end

    def operation
        @vehicle.in_operation!
        redirect_to @vehicle, notice: 'Veiculo passado para Operação com sucesso !!!'
    end

    def indelivery 
        @vehicle.In_delivery!
    end


    private

    def set_category
        @categories = Category.all
    end

    def set_vehicle 
        @vehicle = Vehicle.find(params[:id])
    end

    def vehicle_params 
        params.require(:vehicle).permit(:nameplate, :brand, :vehicle_model, :year_manufacture,
                                        :maximum_load, :status, :category_id)
    end

end