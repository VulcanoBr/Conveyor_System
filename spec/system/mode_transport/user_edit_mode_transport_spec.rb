require 'rails_helper'

describe 'Usuario Edita Modalidade' do

    it 'deve estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'e da pagina incial, link Editar e ve as informaçoes' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Editar'

        # Assert
        expect(*page).to have_content('Editar Modalidade')
        expect(page).to have_field('Nome', with:'Entrega Rapida')
        expect(page).to have_field('Distancia Minima', with: '0')
        expect(page).to have_field('Distancia Maxima', with: '500')
        expect(page).to have_field('Peso Minimo', with: '0')
        expect(page).to have_field('Peso Maximo', with: '200')
        expect(page).to have_field('Taxa de Entrega', with: '10.0')
        have_select 'Status',   selected: 'Active'

    end

    it 'e com sucesso' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Editar'
        
        fill_in 'Nome', with: 'Entrega Expressa'
        fill_in 'Distancia Minima', with: 0
        fill_in 'Distancia Maxima', with: 150
        fill_in 'Peso Minimo',  with: 0
        fill_in 'Peso Maximo', with: 350
        fill_in 'Taxa de Entrega', with: 200
        click_on 'Salvar'

        # Assert
        expect(*page).to have_content('Modalidade atualizada com sucesso !!!')
        expect(*page).to have_content('Modalidade cadastrada/atualizada')
        expect(page).to have_content('Nome: Entrega Expressa')
        expect(page).to have_content('Distancia Minima: 0')
        expect(page).to have_content('Distancia Maxima: 150')
        expect(page).to have_content('Peso Minimo: 0')
        expect(page).to have_content('Peso Maximo: 350')
        expect(page).to have_content('Taxa de Entrega: R$ 200,00')
        expect(page).to have_content('Status: Ativo')
        expect(*page).to have_content('Voltar')
    end

    it 'e sem sucesso, campos obrigatorios' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Editar'
        
        fill_in 'Nome', with: ''
        fill_in 'Distancia Minima', with: ''
        fill_in 'Distancia Maxima', with: ''
        fill_in 'Peso Minimo',  with: ''
        fill_in 'Peso Maximo', with: ''
        fill_in 'Taxa de Entrega', with: ''
        page.has_select?('Status', selected: 'Active')
        click_on 'Salvar'

        # Assert
        expect(*page).to have_content('Modalidade NÂO atualizada !!!')
        expect(*page).to have_content('Editar Modalidade')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('Distancia Minima não pode ficar em branco')
        expect(page).to have_content('Distancia Maxima não pode ficar em branco')
        expect(page).to have_content('Peso Minimo não pode ficar em branco')
        expect(page).to have_content('Peso Maximo não pode ficar em branco')
        expect(page).to have_content('Taxa de Entrega não pode ficar em branco')
        expect(page).to have_content('Distancia Minima não é um número')
        expect(page).to have_content('Distancia Maxima não é um número')
        expect(page).to have_content('Peso Minimo não é um número')
        expect(page).to have_content('Peso Maximo não é um número')
        expect(page).to have_content('Taxa de Entrega não é um número')
        expect(page).to have_content('Status Active')
    end

    it 'e cancelou atualização' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Editar'
        
        click_on 'Cancelar'

        # Assert
        expect(current_path).to eq mode_transports_path
        
    end

end