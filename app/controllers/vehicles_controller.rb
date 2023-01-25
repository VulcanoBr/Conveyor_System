class VehiclesController < ApplicationController

    before_action :authenticate_user!, only:[:new, :create, :show, :edit, :update, :destroy]

    before_action :set_vehicle, only: [:show, :edit, :update]

    before_action :set_category, only: [:new, :create, :edit, :update]

    def index
        @vehicles = Vehicle.all
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