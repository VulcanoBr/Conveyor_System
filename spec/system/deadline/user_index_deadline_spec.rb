require 'rails_helper'

describe 'Usuario ve configurações' do

    it 'de estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'e acessa pagina de Prazo' do
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        
        deadline1 = Deadline.create!(start_distance:0, final_distance: 100, deadline_hours: 24, mode_transport: mod)
        deadline2 = Deadline.create!(start_distance:101, final_distance: 300, deadline_hours: 48,mode_transport: mod)
        deadline3 = Deadline.create!(start_distance:301, final_distance: 600, deadline_hours: 72, mode_transport: mod)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Prazos'

        # Assert
        expect(current_path).to eq mode_transport_deadlines_path(mod.id)
        expect(page).to have_content('Configuração de Prazos')
        expect(page).not_to have_content('Não ha Prazos Cadastrados !!!')
        expect(page).to have_content('0')
        expect(page).to have_content('100')
        expect(page).to have_content('24')

        expect(page).to have_content('101')
        expect(page).to have_content('300')
        expect(page).to have_content('48')
        
        expect(page).to have_content('301')
        expect(page).to have_content('600')
        expect(page).to have_content('72')
        expect(page).to have_content('Voltar')

    end

    it 'e não ha prazos cadastrados' do

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

        # Assert
        expect(page).to have_content('Não ha Prazos Cadastrados !!!')

    end

end