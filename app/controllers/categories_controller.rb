class CategoriesController < ApplicationController

    before_action :authenticate_user!, only:[:new, :create, :show, :edit, :update]

    before_action :set_category, only: [:show, :edit, :update]

    def index 
        @categories = Category.all
    end 

    def new
        @category = Category.new
    end

    def show 
        
    end

    def create 
        @category = Category.new(category_params)
        if @category.save
            redirect_to @category, notice: 'Categoria cadastrado com sucesso !!!'
        else
            flash.now[:notice] = 'Categoria NÃO cadastrado !!!'
            render 'new'
        end

    end

    def edit 

    end

    def update 
        if @category.update(category_params)
            redirect_to @category, notice: 'Categoria atualizado com sucesso !!!'
        else 
            flash.now[:notice] = 'Categoria NÃO atualizado !!!'
            render 'edit'
        end
    end

    private

    def set_category 
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end
    
end