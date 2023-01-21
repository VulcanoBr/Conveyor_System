require 'rails_helper'

describe 'Usuario acessa tela Inicial' do
    
    it 'e ve menu do sistema' do

        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_content('Vulcan Transportadora')
        expect(page).to have_content('Serviços')
        expect(page).to have_content('Cadastro')
        expect(page).to have_content('Login')
        expect(page).to have_content('Pesquisar')

    end
end