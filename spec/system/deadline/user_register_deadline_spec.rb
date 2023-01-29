require 'rails_helper'

describe 'Usuario Cadastra Prazos' do

    it 'de estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'a partir pagina inicial Prazos, ve tela de cadastro' do
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
        click_on 'Prazos'
        click_on 'Cadastrar novo Prazo'

        # Assert
        expect(*page).to have_content('Cadastra novo Prazo')
        expect(page).to have_content('Distancia Inicio')
        expect(page).to have_content('Distancia Final')
        expect(page).to have_content('Prazo')
       
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
        click_on 'Prazos'
        click_on 'Cadastrar novo Prazo'
        fill_in 'Distancia Inicio', with: 0
        fill_in 'Distancia Final', with: 100
        fill_in 'Prazo', with: 24
        click_on 'Salvar'

        # Assert
        expect(*page).to have_content('Prazo cadastrado com sucesso !!!')
        expect(current_path).to eq mode_transport_deadlines_path(mod.id)
        expect(page).to have_content('Configuração de Prazos')
        expect(page).not_to have_content('Não ha Prazos Cadastrados !!!')
        expect(page).to have_content('0')
        expect(page).to have_content('100')
        expect(page).to have_content('24')
       
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
        click_on 'Prazos'
        click_on 'Cadastrar novo Prazo'
        fill_in 'Distancia Inicio', with: ''
        fill_in 'Distancia Final', with: ''
        fill_in 'Prazo', with: ''
        click_on 'Salvar'

        # Assert
     #   expect(current_path).to eq new_mode_transport_deadline_path(mod.id)
        expect(*page).to have_content('Prazo NÃO cadastrado !!!')    
        expect(page).to have_content('Cadastra novo Prazo')
        expect(page).not_to have_content('Não ha Prazos Cadastrados !!!')
        expect(page).to have_content('Distancia Inicio não pode ficar em branco')
        expect(page).to have_content('Distancia Final não pode ficar em branco')
        expect(page).to have_content('Prazo não pode ficar em branco')
       
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
        click_on 'Prazos'
        click_on 'Cadastrar novo Prazo'
        
        click_on 'Cancelar'

        # Assert
        expect(current_path).to eq mode_transport_deadlines_path(mod.id)
        
    end
end