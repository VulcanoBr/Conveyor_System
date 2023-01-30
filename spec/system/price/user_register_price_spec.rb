require 'rails_helper'

describe 'Usuario Cadastra Preços' do

    it 'de estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'a partir pagina inicial Preços, ve tela de cadastro' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Preços'
        click_on 'Cadastrar novo Preço'

        # Assert
        expect(*page).to have_content('Cadastra novo Preço')
        expect(page).to have_content('Peso Inicial')
        expect(page).to have_content('Peso Final')
        expect(page).to have_content('Preço')
       
    end

    it 'com sucesso' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Preços'
        click_on 'Cadastrar novo Preço'
        fill_in 'Peso Inicial', with: 0
        fill_in 'Peso Final', with: 100
        fill_in 'Preço', with: 0.24
        click_on 'Salvar'

        # Assert
        expect(*page).to have_content('Preço cadastrado com sucesso !!!')
        expect(current_path).to eq mode_transport_prices_path(mod.id)
        expect(page).to have_content('Configuração de Preços')
        expect(page).not_to have_content('Não ha Preços Cadastrados !!!')
        expect(page).to have_content('0')
        expect(page).to have_content('100')
        expect(page).to have_content('R$ 0,24')
       
    end

    it 'e sem  sucesso' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Preços'
        click_on 'Cadastrar novo Preço'
        fill_in 'Peso Inicial', with: ''
        fill_in 'Peso Final', with: ''
        fill_in 'Preço', with: ''
        click_on 'Salvar'

        # Assert
     #   expect(current_path).to eq new_mode_transport_price_path(mod.id)
        expect(*page).to have_content('Preço NÃO cadastrado !!!')    
        expect(page).to have_content('Cadastra novo Preço')
        expect(page).not_to have_content('Não ha Preços Cadastrados !!!')
        expect(page).to have_content('Peso Inicial não pode ficar em branco')
        expect(page).to have_content('Peso Final não pode ficar em branco')
        expect(page).to have_content('Preço não pode ficar em branco')
       
    end

    it 'e cancela cadastramento' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Preços'
        click_on 'Cadastrar novo Preço'
        
        click_on 'Cancelar'

        # Assert
        expect(current_path).to eq mode_transport_prices_path(mod.id)
        
    end
end