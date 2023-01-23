require 'rails_helper'

describe 'Usuario remove Categoria' do
    
    it 'com sucesso' do
        
        # Arrange
        category = Category.create!(name: 'Carro')
        user = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password' )
        
        # Act
        login_as(user)                              
        visit root_path
        click_on 'Cadastro'
        click_on 'Categorias'
        click_on 'Remover'

        # Assert
        expect(current_path).to eq categories_path
        expect(page).to have_content('Categoria removido com sucesso !!!')
        expect(page).not_to have_content('Carro')

    end

end