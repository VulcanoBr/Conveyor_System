require 'rails_helper'

describe 'Usuario ve Veiculos' do
    
    it 'e acessa pagina de Veiculos' do
        # Arrange

        visit root_path
        click_on 'Cadastro'
        click_on 'Veiculos'

        # Assert
        expect(current_path).to eq vehicles_path

    end

    it 'com sucesso' do 

        # Arrange'
        category = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'KYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                                   year_manufacture: '2018', maximum_load: 400000, category: category, status: 0)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang', 
                                    year_manufacture: '2020', maximum_load: 250000, category: category, status: :in_operation)

        # Act
        visit root_path
        click_on 'Cadastro'
        click_on 'Veiculos'

        # Assert
        expect(page).not_to have_content('Não ha Veiculos Cadastradas !!!')
        expect(page).to have_content('Veiculos')
        expect(page).to have_content('KYZ-9268')
        expect(page).to have_content('Suzuki')
        expect(page).to have_content('Vitara For You')
        expect(page).to have_content('2018')
        expect(page).to have_content('400000')
        expect(page).to have_content('Carro')
        expect(page).to have_content('Em Operação')

        expect(page).to have_content('XYZ-3454')
        expect(page).to have_content('Ford')
        expect(page).to have_content('Mustang')
        expect(page).to have_content('2020')
        expect(page).to have_content('250000')
        expect(page).to have_content('Carro')
        expect(page).to have_content('Em Operação')

    end

    it 'e não ha veiculoss cadastrados' do

        # Arrange

        # Act
        visit root_path
        click_on 'Cadastro'
        click_on 'Veiculos'

        # Assert
        expect(page).to have_content('Não ha Veiculos Cadastradas !!!')

    end

    it 'e volta para a pagina principal' do

        # Arrange

        # Act
        visit root_path
        click_on 'Cadastro'
        click_on 'Veiculos'
        click_on 'Voltar'

        # Assert
        expect(current_path).to eq root_path

    end
end