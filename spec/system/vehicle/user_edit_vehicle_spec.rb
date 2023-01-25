require 'rails_helper'

describe 'Usuario edita veiculo' do
    
    it 'de estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'Pagina Incial Veiculo, link Editar e ve as informações' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        vehicle2 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
            year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastro'
        click_on 'Veiculos'
        click_on 'Editar'

        # Assert
        expect(page).to have_content('Editar Veiculo')
        expect(page).to have_field('Placa Identificação', with: 'XYZ-3454')
        expect(page).to have_field('Marca', with: 'Ford')
        expect(page).to have_field('Modelo', with: 'Mustang GTX')
        expect(page).to have_field('Ano Fabricação', with: 2020)
        expect(page).to have_field('Carga Maxima', with: 950)
        have_select 'Categoria',   selected: 'Carro' 

    end

    it 'e com sucesso ' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        vehicle2 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
            year_manufacture: '2020', maximum_load: 950, category: category2, status: :in_operation)

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastro'
        click_on 'Veiculos'
        click_on 'Editar'
        fill_in 'Placa Identificação', with: 'KYZ-6292'
        fill_in 'Marca', with: 'Ford'
        fill_in 'Modelo', with: 'Mustang'
        fill_in 'Ano Fabricação', with: 2021
        fill_in 'Carga Maxima', with: 1000
        select 'Carro', from: 'Categoria'
        click_on 'Salvar'

        # Assert 
        expect(page).to have_content('Veiculo atualizado com sucesso !!!')
        expect(page).to have_content('Placa Identificação: KYZ-6292')
        expect(page).to have_content('Marca: Ford')
        expect(page).to have_content('Modelo: Mustang')
        expect(page).to have_content('Ano Fabricação: 2021')
        expect(page).to have_content('Carga Maxima: 1000')
        expect(page).to have_content('Categoria: Carro')
        expect(page).to have_content('Voltar')
    end

    it 'e sem sucesso, campos obrigatorios com sucesso ' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        
        vehicle2 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
            year_manufacture: '2020', maximum_load: 950, category: category2, status: :in_operation)

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastro'
        click_on 'Veiculos'
        click_on 'Editar'
        fill_in 'Placa Identificação', with: ''
        fill_in 'Marca', with: ''
        fill_in 'Modelo', with: ''
        fill_in 'Ano Fabricação', with: ''
        fill_in 'Carga Maxima', with: ''
        page.has_select?('Categoria', selected: 'Carro')
        click_on 'Salvar'

        # Assert 
        expect(page).to have_content('Veiculo NÃO atualizado !!!')
        expect(page).to have_content('Placa Identificação não pode ficar em branco')
        expect(page).to have_content('Marca não pode ficar em branco')
        expect(page).to have_content('Modelo não pode ficar em branco')
        expect(page).to have_content('Ano Fabricação não pode ficar em branco')
        expect(page).to have_content('Carga Maxima não pode ficar em branco')
        expect(page).to have_content('Carro')
        #expect(page).not_to have_content('')
    end

    it 'e cancelou a atualização' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        
        vehicle2 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
            year_manufacture: '2020', maximum_load: 950, category: category2, status: :in_operation)

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastro'
        click_on 'Veiculos'
        click_on 'Editar'
        
        click_on 'Cancelar'


        # Assert
        expect(current_path).to eq vehicles_path
        
    end



end

