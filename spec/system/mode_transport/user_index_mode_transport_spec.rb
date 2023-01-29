require 'rails_helper'

describe 'Usuario ve Modalidades' do

    it 'e acessa pagina de Modalidades' do
        # Arrange

        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
       # within('#modalidade') do
            click_on 'CadMod'
       # end
        # Assert
        expect(current_path).to eq mode_transports_path

    end

    it 'e com sucesso' do
        # Arrange
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
                        minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: 0)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                            minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :active)

        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        
        click_on 'CadMod'

        # Assert
        expect(current_path).to eq mode_transports_path
        expect(page).to have_content('Modalidades de Transporte')
        expect(page).to have_content('Entrega Rapida')
        expect(page).to have_content('0')
        expect(page).to have_content('500')
        expect(page).to have_content('0')
        expect(page).to have_content('200')
        expect(page).to have_content('10.0')
        expect(page).to have_content('0')

        expect(page).to have_content('Entrega Expressa')
        expect(page).to have_content('0')
        expect(page).to have_content('100')
        expect(page).to have_content('0')
        expect(page).to have_content('10')
        expect(page).to have_content('50.0')
        expect(page).to have_content('0')

    end

    it 'e não ha modalidades cadastradas' do

        # Arrange

        # Act
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        
        click_on 'CadMod'

        # Assert
        expect(page).to have_content('Não ha Modalidades Cadastradas !!!')

    end

end