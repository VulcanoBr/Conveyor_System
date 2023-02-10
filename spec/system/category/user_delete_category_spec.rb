require 'rails_helper'

describe 'Usuario remove Categoria' do
    
    it 'com sucesso' do
        
        # Arrange
        category1 = Category.create!(name: "Carro")
        category2 = Category.create!(name: "Moto")
        user = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password' )
        
        # Act
        login_as(user)                              
        visit root_path
        click_on 'Cadastros'
        click_on 'Categorias'
        within('td', id: 'category_1') do
            click_on 'Remover'
        end

        # Assert
        expect(current_path).to eq categories_path
        expect(page).to have_content('Categoria removido com sucesso !!!')
        expect(page).not_to have_content('Carro')

    end

end