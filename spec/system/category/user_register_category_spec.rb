require 'rails_helper'

describe 'Usuario Cadastra Categoria' do

    it ' e deve estar autenticado' do

        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'a partir pagina inicial Categoria, ve tela de cadastro' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Categorias'
        click_on 'Cadastrar nova Categoria'

        # Assert
        expect(page).to have_content('Nova Categoria')
        expect(page).to have_content('Categoria')

    end

    it 'com sucesso' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Categorias'
        click_on 'Cadastrar nova Categoria'
        
        fill_in 'Categoria', with: 'Carro'
        click_on 'Salvar'


        # Assert
        expect(page).to have_content('Categoria cadastrado com sucesso !!')
        expect(page).to have_content('Categoria: Carro')
        expect(page).to have_content('Voltar')

    end

    it 'sem sucesso campo obrigatorio' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Categorias'
        click_on 'Cadastrar nova Categoria'
        
        fill_in 'Categoria', with: ''
        click_on 'Salvar'


        # Assert
        expect(page).to have_content('Categoria NÃO cadastrado !!!')
        expect(page).to have_content('Categoria não pode ficar em branco')

    end

    it 'e cancelou cadastramento' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Categorias'
        click_on 'Cadastrar nova Categoria'
        
        click_on 'Cancelar'


        # Assert
        expect(current_path).to eq categories_path
        
    end
end