require 'rails_helper'

describe 'Usuario Edita Preço' do

    it 'de estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'a partir pagina inicial Preço, link Editar, ve tela de edição' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        Price.create!(start_weight: 0, final_weight: 100, km_price: 0.24, mode_transport_id: mod.id)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Preço'
        click_on 'Editar'

        # Assert
        expect(*page).to have_content('Editar Preço')
        expect(page).to have_field('Peso Inicial', with: 0)
        expect(page).to have_field('Peso Final', with: 100)
        expect(page).to have_field('Preço', with: 0.24)
       
    end

    it 'e com sucesso ' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        Price.create!(start_weight: 0, final_weight: 100, km_price: 0.24, mode_transport_id: mod.id)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Preço'
        click_on 'Editar'
        fill_in 'Peso Inicial', with: 0
        fill_in 'Peso Final', with: 150
        fill_in 'Preço', with: 0.28
        click_on 'Salvar'

        # Assert
        expect(*page).to have_content('Preço atualizado com sucesso !!!')
        expect(current_path).to eq mode_transport_prices_path(mod.id)
        expect(page).to have_content('Configuração de Preço')
        expect(page).not_to have_content('Não ha Preço Cadastrados !!!')
        expect(page).to have_content('0')
        expect(page).to have_content('150')
        expect(page).to have_content('R$ 0,28')
       
    end

    it 'e sem sucesso, campos obrigatorios ' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        Price.create!(start_weight: 0, final_weight: 100, km_price: 0.24, mode_transport_id: mod.id)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Preço'
        click_on 'Editar'
        fill_in 'Peso Inicial', with: ''
        fill_in 'Peso Final', with: ''
        fill_in 'Preço', with: ''
        click_on 'Salvar'

        # Assert
        expect(*page).to have_content('Preço NÃO atualizado !!!')    
        expect(page).to have_content('Editar Preço')
        expect(page).not_to have_content('Não ha Preço Cadastrados !!!')
        expect(page).to have_content('Peso Inicial não pode ficar em branco')
        expect(page).to have_content('Peso Final não pode ficar em branco')
        expect(page).to have_content('Preço não pode ficar em branco')
       
    end

    it 'e cancela edição ' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        Price.create!(start_weight: 0, final_weight: 100, km_price: 0.24, mode_transport_id: mod.id)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Preço'
        click_on 'Editar'
        
        click_on 'Cancelar'

        # Assert
        expect(current_path).to eq mode_transport_prices_path(mod.id)
       
    end

end