require 'rails_helper'

describe 'Usuario ve Categorias' do
    
    it 'acessa pagina de Categoria' do

        # Arrange

        # Act
        visit root_path
        click_on 'Cadastros'
        click_on 'Categorias'

        # Assert
        expect(current_path).to eq categories_path

    end 

    it 'com sucesso' do

        # Arrange
        category1 = Category.create!(name: "Carro")
        category2 = Category.create!(name: "Moto")
        # Act
        visit root_path
        click_on 'Cadastros'
        click_on 'Categorias'

        # Assert
        expect(page).not_to have_content('Não Categorias Cadastradas !!!')
        expect(page).to have_content('Categoria(s)')
        expect(page).to have_content(category1.id)
        expect(page).to have_content('Carro')
        expect(page).to have_content(category2.id)
        expect(page).to have_content('Moto')

    end

    it 'e não ha categorias cadastradas' do

        # Arrange

        # Act
        visit root_path
        click_on 'Cadastros'
        click_on 'Categorias'

        # Assert
        expect(page).to have_content('Não ha Categorias Cadastradas !!!')

    end

    it 'e volta para a pagina principal' do

        # Arrange

        # Act
        visit root_path
        click_on 'Cadastros'
        click_on 'Categorias'
        click_on 'Voltar'

        # Assert
        expect(current_path).to eq root_path

    end

end