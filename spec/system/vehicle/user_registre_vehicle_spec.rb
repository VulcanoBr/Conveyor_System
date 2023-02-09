require 'rails_helper'

describe 'Usuario cadastra veiculo' do

    it 'deve estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'a partir pagina inicial Veiculo, ve tela de cadastro' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Cadastro'
        click_on 'Cadastrar novo Veiculo'

        # Assert
        expect(*page).to have_content('Novo Veiculo')
        expect(page).to have_field('Placa Identificação')
        expect(page).to have_field('Marca')
        expect(page).to have_field('Modelo')
        expect(page).to have_field('Ano Fabricação')
        expect(page).to have_field('Carga Maxima')
        expect(page).to have_field('Categoria')
       
    end

    it 'com sucesso' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Cadastro'
        click_on 'Cadastrar novo Veiculo'
        fill_in 'Placa Identificação', with: 'KYZ-6292'
        fill_in 'Marca', with: 'Ford'
        fill_in 'Modelo', with: 'Mustang GTX'
        fill_in 'Ano Fabricação', with: 2020
        fill_in 'Carga Maxima', with: 4000
        select 'Carro', from: 'Categoria'
        click_on 'Salvar'


        # Assert
        expect(*page).to have_content('Veiculo cadastrado com sucesso !!!')
        expect(page).to have_content('Placa Identificação: KYZ-6292')
        expect(page).to have_content('Marca: Ford')
        expect(page).to have_content('Modelo: Mustang GTX')
        expect(page).to have_content('Ano Fabricação: 2020')
        expect(page).to have_content('Carga Maxima: 4000')
        expect(page).to have_content('Categoria: Carro')
        expect(page).to have_content('Status: Em Operaçã')
        expect(page).to have_content('Voltar')
       


    end

    it 'e sem sucesso, campos obrigatorios' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        category1 = Category.create!(name: 'Carro')
        category2 = Category.create!(name: 'Moto')
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Cadastro'
        click_on 'Cadastrar novo Veiculo'
        fill_in 'Placa Identificação', with: ''
        fill_in 'Marca', with: ''
        fill_in 'Modelo', with: ''
        fill_in 'Ano Fabricação', with: ''
        fill_in 'Carga Maxima', with: ''
        page.has_select?('Categoria', selected: '')
        click_on 'Salvar'

        # Assert
        expect(page).to have_content('Veiculo NÃO cadastrado !!!')
        expect(page).to have_content('Placa Identificação não pode ficar em branco')
        expect(page).to have_content('Marca não pode ficar em branco')
        expect(page).to have_content('Modelo não pode ficar em branco')
        expect(page).to have_content('Ano Fabricação não pode ficar em branco')
        expect(page).to have_content('Carga Maxima não pode ficar em branco')
        expect(page).to have_content('Categoria não pode ficar em branco')
    
    end


    it 'e cancelou cadastramento' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Cadastros'
        click_on 'Veiculos'
        click_on 'Cadastro'
        click_on 'Cadastrar novo Veiculo'
        
        click_on 'Cancelar'


        # Assert
        expect(current_path).to eq vehicles_path
        
    end

end