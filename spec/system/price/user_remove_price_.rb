require 'rails_helper'

describe 'Usuario remove Preço' do

    it 'de estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'e acessa pagina de Preço' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        preco1 =  Price.create!(start_weight: 0, final_weight: 100, km_price: 0.24, mode_transport_id: mod.id)
        preco2 = Price.create!(start_weight: 101, final_weight: 200, km_price: 0.48, mode_transport_id: mod.id)
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Preços'

        # Assert
        expect(current_path).to eq mode_transport_prices_path(mod.id)
        expect(page).to have_content('Configuração de Preços')
        expect(page).not_to have_content('Não ha Preços Cadastrados !!!')
        expect(page).to have_content('0')
        expect(page).to have_content('100')
        expect(page).to have_content('R$ 0,24')

        expect(page).to have_content('101')
        expect(page).to have_content('200')
        expect(page).to have_content('R$ 0,48')

    end
    
    it 'com sucesso' do
        
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        preco1 =  Price.create!(start_weight: 0, final_weight: 100, km_price: 0.24, mode_transport_id: mod.id)
        preco2 = Price.create!(start_weight: 101, final_weight: 200, km_price: 0.48, mode_transport_id: mod.id)
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Preços'
        
        click_on 'OUTRONOME'

        # Assert
        expect(current_path).to eq mode_transport_prices_path(mod.id)
        expect(page).to have_content('Preço removido com sucesso !!!')
        expect(page).to have_content('Configuração de Preços')
        expect(page).not_to have_content('Não ha Preços Cadastrados !!!')
        expect(page).not_to have_content('0')
        expect(page).not_to have_content('100')
        expect(page).not_to have_content('R$ 0,24')

        expect(page).to have_content('101')
        expect(page).to have_content('200')
        expect(page).to have_content('R$ 0,48')

    end

end