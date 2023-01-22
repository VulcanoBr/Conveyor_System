require 'rails_helper'

describe 'Usuario faz Cadastro de Autenticação' do
    
    it 'com sucesso' do
        # Arrange
        
        # Act
        visit root_path
        click_on 'Login'
        click_on 'Criar uma Conta'
        fill_in 'Nome', with: 'Vulcano'
        fill_in 'E-mail', with: 'vulcano@email.com'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirmar Senha', with: 'password'
        click_on 'Criar Conta'

        # Assert
        expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
        expect(page).to have_button 'Sair'
        user = User.last
        expect(user.name).to eq 'Vulcano' 
    end

    it 'e falha com nome, email e senha invalidos' do
        # Arrange
        
        # Act
        visit root_path
        click_on 'Login'
        click_on 'Criar uma Conta'
        fill_in 'Nome', with: ''
        fill_in 'E-mail', with: 'email.com'
        fill_in 'Senha', with: ''
        fill_in 'Confirmar Senha', with: 'password'
        click_on 'Criar Conta'

        # Assert
        expect(page).to have_content('Não foi possível salvar usuario')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('E-mail não é válido')
        expect(page).to have_content('Senha não pode ficar em branco')
        expect(page).to have_content('Confirmar Senha não é igual a Senha') 
    end

    it 'e falha com nome, email e senha sem preenchimento' do
        # Arrange
        
        # Act
        visit root_path
        click_on 'Login'
        click_on 'Criar uma Conta'
        fill_in 'Nome', with: ''
        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: ''
        fill_in 'Confirmar Senha', with: '33'
        click_on 'Criar Conta'

        # Assert
        expect(page).to have_content('Não foi possível salvar usuario')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('E-mail não pode ficar em branco')
        expect(page).to have_content('Senha não pode ficar em branco')
        expect(page).to have_content('Confirmar Senha não é igual a Senha') 
    end
end