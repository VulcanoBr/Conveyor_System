require 'rails_helper'

describe 'Usuario ve Lista ' do

    it 'da frota de veiculos' do

        # Arrange
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Mini Furgão')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :under_maintenance)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_delivery)
        vehicle3 = Vehicle.create!(nameplate:'KYZ-1313', brand: 'Fiat', vehicle_model: 'Fiorino', 
                            year_manufacture: '2019', maximum_load: 450, category: category2, status: :in_operation)
        # Act
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Lista Frota'

        # Assert
        expect(current_path).to eq list_vehicles_path
        expect(page).to have_field('Placa Identificação')
        expect(page).to have_button('Buscar')
        expect(page).not_to have_content('Não ha Veiculos Cadastradas !!!')
        expect(page).to have_content('XYZ-3454')
        expect(page).to have_content('Ford')
        expect(page).to have_content('Mustang GTX')
        expect(page).to have_content('2020')
        expect(page).to have_content('950')
        expect(page).to have_content('Carro')
        expect(page).to have_content('Em Manutenção')

        expect(page).to have_content('XYZ-9268')
        expect(page).to have_content('Suzuki')
        expect(page).to have_content('Vitara For You')
        expect(page).to have_content('2018')
        expect(page).to have_content('800')
        expect(page).to have_content('Carro')
        expect(page).to have_content('Em Entrega')

        expect(page).to have_content('KYZ-1313')
        expect(page).to have_content('Fiat')
        expect(page).to have_content('Fiorino')
        expect(page).to have_content('2019')
        expect(page).to have_content('450')
        expect(page).to have_content('Mini Furgão')
        expect(page).to have_content('Em Operação')
        expect(page).to have_content('Voltar')

    end

    it 'e encontra um veiculo' do

        # Arrange
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        vehicle = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        # Act
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Lista Frota'
        fill_in 'Placa Identificação', with: vehicle.nameplate
        click_on 'Buscar'

        # Assert
        expect(current_path).to eq list_vehicles_path
        expect(page).not_to have_content('Não ha Veiculos Cadastrados !!!')
        expect(page).to have_content('XYZ-3454')
        expect(page).to have_content('Ford')
        expect(page).to have_content('Mustang GTX')
        expect(page).to have_content('2020')
        expect(page).to have_content('950')
        expect(page).to have_content('Carro')
        expect(page).to have_content('Em Operação')
        expect(page).to have_content('Voltar')

    end

    it 'e encontra multiplos veiculos' do

        # Arrange
        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
            year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Lista Frota'
        fill_in 'Placa Identificação', with: 'XYZ'
        click_on 'Buscar'
        # Assert
        expect(page).not_to have_content('Não ha Veiculos Cadastrados !!!')
        expect(current_path).to eq list_vehicles_path
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
        expect(page).to have_content('Voltar')
    end

    it 'e veiculo pesquisado não encontrado' do

        # Arrange
        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
            year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Lista Frota'
        fill_in 'Placa Identificação', with: 'FRT-5656'
        click_on 'Buscar'

        # Assert
        expect(page).not_to have_content('Não ha Veiculos Cadastradas !!!')
        expect(page).to have_content('Veiculo FRT-5656 não encontrado !!!')
        expect(page).to have_content('Voltar')
    end

    it 'e não ha veiculos cadastrados' do

        # Arrange

        #Act
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Lista Frota'
        # Assert
        expect(page).to have_content('Não ha Veiculos Cadastrados !!!')

    end
end