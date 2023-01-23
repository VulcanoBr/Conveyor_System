class CategoriesController < ApplicationController

    before_action :set_category, only: [:show]

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

    private

    def set_category 
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end
    
end