require 'rails_helper'

describe 'Usuario se autentica' do
    
    it 'com sucesso' do

        # Arrane
        User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')

        # Act
        visit root_path
        click_on 'Login'
        fill_in 'E-mail', with: 'vulcano@email.com'
        fill_in 'Senha', with: 'password'
        click_on 'Entrar'

        # Assert
        expect(page).to have_content('Login efetuado com sucesso')
        within('nav') do
            expect(page).not_to have_link('Login')
            expect(page).to have_button('Sair')
            expect(page).to have_content('Vulcano')
        end
        
    end

    it 'sem sucesso' do

        # Arrane
        User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')

        # Act
        visit root_path
        click_on 'Login'
        fill_in 'E-mail', with: 'email.com'
        fill_in 'Senha', with: 'pasrd'
        click_on 'Entrar'

        # Assert
        expect(page).to have_content('E-mail ou senha inválidos')
        within('nav') do
            expect(page).to have_link('Login')
            expect(page).not_to have_button('Sair')
            expect(page).not_to have_content('Vulcano')
        end
        
    end

    it 'faz Logout' do

        # Arrane
        User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')

        # Act
        visit root_path
        click_on 'Login'
        fill_in 'E-mail', with: 'vulcano@email.com'
        fill_in 'Senha', with: 'password'
        click_on 'Entrar'
        click_on 'Sair'

        # Assert
        expect(page).to have_content('Logout efetuado com sucesso')
        within('nav') do
            expect(page).to have_link('Login')
            expect(page).not_to have_button('Sair')
            expect(page).not_to have_content('Vulcano')
        end
        
    end

end