require 'rails_helper'

describe 'Usuario Cadastra Modalidade' do

    it 'de estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'a partir pagina inicial Modalidade, ve tela de cadastro' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Cadastrar nova Modalidade'

        # Assert
        expect(*page).to have_content('Nova Modalidade')
        expect(page).to have_field('Nome')
        expect(page).to have_field('Distancia Minima')
        expect(page).to have_field('Distancia Maxima')
        expect(page).to have_field('Peso Minimo')
        expect(page).to have_field('Peso Maximo')
        expect(page).to have_field('Taxa de Entrega')
       
    end

    it 'com sucesso' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Cadastrar nova Modalidade'
        
        fill_in 'Nome', with: 'Entrega Rapida'
        fill_in 'Distancia Minima', with: 0
        fill_in 'Distancia Maxima', with: 200
        fill_in 'Peso Minimo',  with: 0
        fill_in 'Peso Maximo', with: 450
        fill_in 'Taxa de Entrega', with: 100
        click_on 'Salvar'

        # Assert
        expect(*page).to have_content('Modalidade cadastrada com sucesso !!!')
        expect(*page).to have_content('Modalidade cadastrada/atualizada')
        expect(page).to have_content('Nome: Entrega Rapida')
        expect(page).to have_content('Distancia Minima: 0')
        expect(page).to have_content('Distancia Maxima: 200')
        expect(page).to have_content('Peso Minimo: 0')
        expect(page).to have_content('Peso Maximo: 450')
        expect(page).to have_content('Taxa de Entrega: R$ 100,00')
        expect(page).to have_content('Status: Ativo')
        expect(*page).to have_content('Voltar')
    end

    it 'sem  sucesso campos obrigatorios' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Modalidades'
        click_on 'CadMod'
        click_on 'Cadastrar nova Modalidade'
        
        fill_in 'Nome', with: ''
        fill_in 'Distancia Minima', with: ''
        fill_in 'Distancia Maxima', with: ''
        fill_in 'Peso Minimo',  with: ''
        fill_in 'Peso Maximo', with: ''
        fill_in 'Taxa de Entrega', with: ''
        click_on 'Salvar'

        # Assert
        expect(*page).to have_content('Modalidade NÃO cadastrada !!!')
        expect(*page).to have_content('Nova Modalidade')
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
        
    end

    it 'e cancelou cadastramento' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'CadMod'
        click_on 'Cadastrar nova Modalidade'
        
        click_on 'Cancelar'


        # Assert
        expect(current_path).to eq mode_transports_path
        
    end
end

