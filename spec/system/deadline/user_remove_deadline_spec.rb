require 'rails_helper'

describe 'Usuario remove Prazo' do

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
        dead1 =  Deadline.create!(start_distance: 0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod.id)
        dead2 = Deadline.create!(start_distance: 101, final_distance: 200, deadline_hours: 48, mode_transport_id: mod.id)
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
        expect(page).to have_content('200')
        expect(page).to have_content('48')

    end
    
    it 'com sucesso' do
        
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        dead1 =  Deadline.create!(start_distance: 103, final_distance: 110, deadline_hours: 24, mode_transport_id: mod.id)
        dead2 = Deadline.create!(start_distance: 101, final_distance: 200, deadline_hours: 48, mode_transport_id: mod.id)
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Prazos'
        within('td', id: 'deadline_1') do
            click_on 'Remover'
        end

        # Assert
        expect(current_path).to eq mode_transport_deadlines_path(mod.id)
        expect(page).to have_content('Prazo removido com sucesso !!!')
        expect(page).to have_content('Configuração de Prazos, Modalidade: Entrega Rapida')
        expect(page).not_to have_content('Não ha Prazos Cadastrados !!!')
        expect(page).not_to have_content('103')
        expect(page).not_to have_content('110')
        expect(page).not_to have_content('24')

        expect(page).to have_content('101')
        expect(page).to have_content('200')
        expect(page).to have_content('48')

    end

end