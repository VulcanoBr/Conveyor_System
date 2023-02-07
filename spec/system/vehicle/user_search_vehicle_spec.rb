require 'rails_helper'

describe 'Usuario busca veiculo' do

    
    it 'e acessa pagina de Veiculos' do
        # Arrange

        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Cadastro'

        # Assert
        expect(current_path).to eq vehicles_path
        expect(page).to have_field('Placa Identificação')
        expect(page).to have_button('Buscar')

    end

    it 'e encontra um veiculo' do
        # Arrange
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        vehicle = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Cadastro'
        within( 'div#veiculo') do
            fill_in 'Placa Identificação', with: vehicle.nameplate
        end
        click_on 'Buscar'

        # Assert
        expect(current_path).to eq vehicles_path
        expect(page).to have_content('XYZ-3454')
        expect(page).to have_content('Ford')
        expect(page).to have_content('Mustang GTX')
        expect(page).to have_content('2020')
        expect(page).to have_content('950')
        expect(page).to have_content('Carro')
        expect(page).to have_content('Operação')

    end

    it 'e encontra multiplos veiculos' do
        # Arrange
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Cadastro'
        within('div#veiculo')  do
            fill_in 'Placa Identificação', with: 'XYZ-'
        end
        click_on 'Buscar'

        # Assert
        expect(current_path).to eq vehicles_path
        expect(page).to have_content('XYZ-3454')
        expect(page).to have_content('Ford')
        expect(page).to have_content('Mustang GTX')
        expect(page).to have_content('2020')
        expect(page).to have_content('950')
        expect(page).to have_content('Carro')
        expect(page).to have_content('Em Operação')

        expect(page).to have_content('XYZ-9268')
        expect(page).to have_content('Suzuki')
        expect(page).to have_content('Vitara For You')
        expect(page).to have_content('2018')
        expect(page).to have_content('800')
        expect(page).to have_content('Carro')
        expect(page).to have_content('Em Operação')

    end


end