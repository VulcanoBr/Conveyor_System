require 'rails_helper'
 
describe 'Usuario edita Categoria' do

    it ' e deve estr autenticado' do

        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'Pagina Incial Categoria, link Editar e ve as informações' do

        # Arrange
        category = Category.create!(name:'Carro')
        
        user = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password' )
        
        # Act
        login_as(user)                              
        visit root_path
        click_on 'Cadastro'
        click_on 'Categorias'
        click_on 'Editar'

        # Assert
        expect(page).to have_content('Editar Categoria')
        expect(page).to have_field('Categoria', with: 'Carro')

    end

    it 'edita com sucesso' do

        # Arrange
        category = Category.create!(name:'Carro')
        
        user = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password' )
        
        # Act
        login_as(user)                              
        visit root_path
        click_on 'Cadastro'
        click_on 'Categorias'
        click_on 'Editar'
        fill_in 'Categoria', with: 'Moto'
        click_on 'Salvar'

        # Assert
        expect(page).to have_content('Categoria atualizado com sucesso !!')
        expect(page).to have_content('Categoria: Moto')
        expect(page).to have_content('Voltar')

    end

    it 'edita sem sucesso, campos obrigatorios' do

        # Arrange
        category = Category.create!(name:'Carro')
        
        user = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password' )
        
        # Act
        login_as(user)                              
        visit root_path
        click_on 'Cadastro'
        click_on 'Categorias'
        click_on 'Editar'
        fill_in 'Categoria', with: ''
        click_on 'Salvar'

        # Assert
        expect(page).to have_content('Categoria NÃO atualizado !!!')
        expect(page).to have_content('Categoria não pode ficar em branco')

    end

    it 'e cancela edição' do

        # Arrange
        category = Category.create!(name:'Carro')
        
        user = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password' )
        
        # Act
        login_as(user)                              
        visit root_path
        click_on 'Cadastro'
        click_on 'Categorias'
        click_on 'Editar'
       
        click_on 'Cancelar'

        # Assert
        expect(current_path).to eq categories_path

    end


end