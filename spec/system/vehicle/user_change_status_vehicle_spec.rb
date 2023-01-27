require 'rails_helper'

describe 'Usuario altera status do veiculo' do

    it 'e deve estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'e colocar em manutenção' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        vehicle = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
            year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Cadastro'
        click_on 'Em Manutenção'

        # Assert
        expect(current_path).to eq vehicle_path(vehicle.id)
        expect(page).to have_content('Veiculo passado para Manutenção com sucesso !!!')
        expect(page).to have_content('Status: Em Manutenção')
        expect(page).to have_content('Voltar')
      #  expect(page).not_to have_button ('Em Manutenção')

    end

    it 'e colocar em operação' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        vehicle = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
            year_manufacture: '2020', maximum_load: 950, category: category1, status: :under_maintenance)

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Cadastro'
        click_on 'Em Operação'

        # Assert
        expect(current_path).to eq vehicle_path(vehicle.id)
        expect(page).to have_content('Veiculo passado para Operação com sucesso !!!')
        expect(page).to have_content('Status: Em Operação')
        expect(page).to have_content('Voltar')
      #  expect(page).not_to have_button ('Em Manutenção')

    end

    it 'e não mostra opção para manutenção / operação' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        vehicle = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
            year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_delivery)

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Cadastro'
        

        # Assert
        expect(current_path).to eq vehicles_path
        expect(page).to have_content('Em Entrega')
        expect(page).not_to have_button('Em Operação')
        expect(page).not_to have_button('Em Manutenção')

    end

end