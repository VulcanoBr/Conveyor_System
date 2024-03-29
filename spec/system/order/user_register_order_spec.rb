require 'rails_helper'

describe 'Usaurio cadastra Pedido de Entrega' do

    
    it 'deve estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'e com sucesso' do 

        #Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        allow(SecureRandom).to receive(:alphanumeric).and_return("XXX1234567890XX")
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Criar Ordem de Entrega'

        fill_in 'Codigo Produto', with: 'Codigo produto'
        fill_in 'Descrição', with: 'Descrição'
        fill_in 'Peso', with: '40'
        fill_in 'Altura', with: '35'
        fill_in 'Largura', with: '45'
        fill_in 'Profundidade', with: '10'
        fill_in 'Descrição', with: 'Descrição'
        fill_in 'Nome Remetente', with: 'João da Silva'
        fill_in 'CPF/CNPJ Remetente', with: '624.299.657-04'
        fill_in 'Email Remetente', with: 'silva@email.com'
        fill_in 'Telefone Remetente', with: '21 988975959'
        fill_in 'enderecoRemetente', with: 'Rua sem saida'
        fill_in 'numeroRemetente', with: '123'
        fill_in 'complementoRemetente', with: 'casa 1'
        fill_in 'bairroRemetente', with: 'Gavea'
        fill_in 'cidadeRemetente', with: 'Rio de Janeiro'
        fill_in 'estadoRemetente', with: 'RJ'
        fill_in 'cepRemetente', with: '22755-170'
        fill_in 'Nome Destinatario', with: 'Maria da Silva'
        fill_in 'CPF/CNPJ Destinatario', with: '784.989.240-22'
        fill_in 'Email Destinatario', with: 'maria@email.com'
        fill_in 'Telefone Destinatario', with: '21 988972929'
        fill_in 'enderecoDestinatario', with: 'Rua com saida'
        fill_in 'numeroDestinatario', with: '1.234'
        fill_in 'complementoDestinatario', with: 'sala 1'
        fill_in 'bairroDestinatario', with: 'Cascdura'
        fill_in 'cidadeDestinatario', with: 'Rio de Janeiro'
        fill_in 'estadoDestinatario', with: 'RJ'
        fill_in 'cepDestinatario', with: '22755-200'
        
        
        fill_in 'Distancia', with: '959'
        click_on 'Salvar'

        # Assert
        expect(page).to have_content('Ordem de Entrega criado com sucesso !!!')
        expect(page).to have_content('Codigo do Pedido: XXX1234567890XX')
        expect(page).to have_content('Codigo Produto: Codigo produto')
        expect(page).to have_content('Descrição: Descrição')
        expect(page).to have_content('Peso: 40')
        expect(page).to have_content('Altura: 35')
        expect(page).to have_content('Largura: 45')
        expect(page).to have_content('Profundidade: 10')
        
        expect(page).to have_content('Nome Remetente: João da Silva')
        expect(page).to have_content('CPF/CNPJ Remetente: 624.299.657-04')
        expect(page).to have_content('Email Remetente: silva@email.com')
        expect(page).to have_content('Telefone Remetente: 21 988975959')
        expect(page).to have_content('Endereço Remetente: Rua sem saida')
        expect(page).to have_content('Numero Remetente: 123')
        expect(page).to have_content('Complemento Remetente: casa 1')
        expect(page).to have_content('Bairro Remetente: Gavea')
        expect(page).to have_content('Cidade Remetente: Rio de Janeiro')
        expect(page).to have_content('Estado Remetente: RJ')
        expect(page).to have_content('Cep Remetente: 22755-170')
        expect(page).to have_content('Nome Destinatario: Maria da Silva')
        expect(page).to have_content('CPF/CNPJ Destinatario: 784.989.240-22')
        expect(page).to have_content('Email Destinatario: maria@email.com')
        expect(page).to have_content('Telefone Destinatario: 21 988972929')
        expect(page).to have_content('Endereço Destinatario: Rua com saida')
        expect(page).to have_content('Numero Destinatario: 1.234')
        expect(page).to have_content('Complemento Destinatario: sala 1')
        expect(page).to have_content('Bairro Destinatario: Cascdura')
        expect(page).to have_content('Cidade Destinatario: Rio de Janeiro')
        expect(page).to have_content('Estado Destinatario: RJ')
        expect(page).to have_content('Cep Destinatario: 22755-200')
      
        expect(page).to have_content('Distancia: 959')
        expect(page).to have_content('Voltar')    
    end

    it 'e sem sucesso, campos obrigatorios' do 

        #Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Criar Ordem de Entrega'

        fill_in 'Codigo Produto', with: ''
        fill_in 'Peso', with: ''
        fill_in 'Altura', with: ''
        fill_in 'Largura', with: ''
        fill_in 'Profundidade', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Nome Remetente', with: ''
        fill_in 'CPF/CNPJ Remetente', with: ''
        fill_in 'Email Remetente', with: ''
        fill_in 'Telefone Remetente', with: ''
        fill_in 'enderecoRemetente', with: ''
        fill_in 'numeroRemetente', with: ''
        fill_in 'complementoRemetente', with: ''
        fill_in 'bairroRemetente', with: ''
        fill_in 'cidadeRemetente', with: ''
        fill_in 'estadoRemetente', with: ''
        fill_in 'cepRemetente', with: ''
        fill_in 'Nome Destinatario', with: ''
        fill_in 'CPF/CNPJ Destinatario', with: ''
        fill_in 'Email Destinatario', with: ''
        fill_in 'Telefone Destinatario', with: ''
        fill_in 'enderecoDestinatario', with: ''
        fill_in 'numeroDestinatario', with: ''
        fill_in 'complementoDestinatario', with: ''
        fill_in 'bairroDestinatario', with: ''
        fill_in 'cidadeDestinatario', with: ''
        fill_in 'estadoDestinatario', with: ''
        fill_in 'cepDestinatario', with: ''       
        
        fill_in 'Distancia', with: ''
        click_on 'Salvar'

        # Assert
        expect(page).to have_content('Ordem de Entrega NÃO criado !!!')
        expect(page).to have_content('Codigo Produto não pode ficar em branco')
        expect(page).to have_content('Peso não pode ficar em branco')
        expect(page).to have_content('Altura não pode ficar em branco')
        expect(page).to have_content('Largura não pode ficar em branco')
        expect(page).to have_content('Profundidade não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Nome Remetente não pode ficar em branco')
        expect(page).to have_content('CPF/CNPJ Remetente não pode ficar em branco')
        expect(page).to have_content('Email Remetente não pode ficar em branco')
        expect(page).to have_content('Telefone Remetente não pode ficar em branco')
        expect(page).to have_content('Endereço Remetente não pode ficar em branco')
        expect(page).to have_content('Cidade Remetente não pode ficar em branco')
        expect(page).to have_content('Estado Remetente não pode ficar em branco')
        expect(page).to have_content('Cep Remetente não pode ficar em branco')
        expect(page).to have_content('Nome Destinatario não pode ficar em branco')
        expect(page).to have_content('CPF/CNPJ Destinatario não pode ficar em branco')
        expect(page).to have_content('Email Destinatario não pode ficar em branco')
        expect(page).to have_content('Telefone Destinatario não pode ficar em branco')
        expect(page).to have_content('Endereço Destinatario não pode ficar em branco')
        expect(page).to have_content('Cidade Destinatario não pode ficar em branco')
        expect(page).to have_content('Estado Destinatario não pode ficar em branco')
        expect(page).to have_content('Cep Destinatario não pode ficar em branco')
      
        expect(page).to have_content('Distancia não pode ficar em branco')        
           
    end

    it 'e cancelou cadastramento' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Criar Ordem de Entrega'
        
        click_on 'Cancelar'


        # Assert
        expect(current_path).to eq root_path
        
    end

end 
