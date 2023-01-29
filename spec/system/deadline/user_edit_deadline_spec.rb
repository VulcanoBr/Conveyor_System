require 'rails_helper'

describe 'Usuario Edita prazos' do

    it 'de estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'a partir pagina inicial Prazos, link Editar, ve tela de edição' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        Deadline.create!(start_distance: 0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod.id)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Prazos'
        click_on 'Editar'

        # Assert
        expect(*page).to have_content('Editar Prazo')
        expect(page).to have_field('Distancia Inicio', with: 0)
        expect(page).to have_field('Distancia Final', with: 100)
        expect(page).to have_field('Prazo', with: 24)
       
    end

    it 'e com sucesso ' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        Deadline.create!(start_distance: 0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod.id)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Prazos'
        click_on 'Editar'
        fill_in 'Distancia Inicio', with: 0
        fill_in 'Distancia Final', with: 150
        fill_in 'Prazo', with: 28
        click_on 'Salvar'

        # Assert
        expect(*page).to have_content('Prazo atualizado com sucesso !!!')
        expect(current_path).to eq mode_transport_deadlines_path(mod.id)
        expect(page).to have_content('Configuração de Prazos')
        expect(page).not_to have_content('Não ha Prazos Cadastrados !!!')
        expect(page).to have_content('0')
        expect(page).to have_content('150')
        expect(page).to have_content('28')
       
    end

    it 'e sem sucesso, campos obrigatorios ' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        Deadline.create!(start_distance: 0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod.id)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Prazos'
        click_on 'Editar'
        fill_in 'Distancia Inicio', with: ''
        fill_in 'Distancia Final', with: ''
        fill_in 'Prazo', with: ''
        click_on 'Salvar'

        # Assert
        expect(*page).to have_content('Prazo NÃO atualizado !!!')    
        expect(page).to have_content('Editar Prazo')
        expect(page).not_to have_content('Não ha Prazos Cadastrados !!!')
        expect(page).to have_content('Distancia Inicio não pode ficar em branco')
        expect(page).to have_content('Distancia Final não pode ficar em branco')
        expect(page).to have_content('Prazo não pode ficar em branco')
       
    end

    it 'e cancela edição ' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        Deadline.create!(start_distance: 0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod.id)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Prazos'
        click_on 'Editar'
        
        click_on 'Cancelar'

        # Assert
        expect(current_path).to eq mode_transport_deadlines_path(mod.id)
       
    end

end