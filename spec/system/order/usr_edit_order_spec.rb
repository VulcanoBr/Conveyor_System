require 'rails_helper'

describe 'Usuario Edita Pedido de Entrega' do
    it 'de estar autenticado' do
    
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
        order = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 1200, user_id: usuario.id,
            sender_name: 'Joaqui Severo', sender_identification: 12345678901, sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: 62429965704, recipient_email: 'lili@email.com', recipient_phone: '21988887676',
            recipient_address: 'Avenida Silçva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)
        codigo_atual = order.code
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'
        click_on 'Editar'

        fill_in 'Codigo Produto', with: 'Codigo produto'
        fill_in 'Descrição', with: 'Descrição'
        fill_in 'Peso', with: '40'
        fill_in 'Altura', with: '35'
        fill_in 'Largura', with: '45'
        fill_in 'Profundidade', with: '10'
        fill_in 'Descrição', with: 'Descrição'
        fill_in 'Nome Remetente', with: 'João da Silva'
        fill_in 'CPF Remetente', with: '62429965704'
        fill_in 'Email Remetente', with: 'silva@email.com'
        fill_in 'Telefone Remetente', with: '21 988975959'
        fill_in 'Endereço Remetente', with: 'Rua sem saida'
        fill_in 'Cidade Remetente', with: 'Rio de Janeiro'
        fill_in 'Estado Remetente', with: 'RJ'
        fill_in 'Cep Remetente', with: '22755-170'
        fill_in 'Nome Destinatario', with: 'Maria da Silva'
        fill_in 'CPF Destinatario', with: '62429965789'
        fill_in 'Email Destinatario', with: 'maria@email.com'
        fill_in 'Telefone Destinatario', with: '21 988972929'
        fill_in 'Endereço Destinatario', with: 'Rua com saida'
        fill_in 'Cidade Destinatario', with: 'Rio de Janeiro'
        fill_in 'Estado Destinatario', with: 'RJ'
        fill_in 'Cep Destinatario', with: '22755-200'
        
        
        fill_in 'Distancia', with: '959'
        click_on 'Salvar'

        # Assert
        expect(page).to have_content('Ordem de Entrega atualizada com sucesso !!!')
        expect(page).to have_content("Codigo do Pedido: #{codigo_atual}")
        expect(page).to have_content('Codigo Produto: Codigo produto')
        expect(page).to have_content('Descrição: Descrição')
        expect(page).to have_content('Peso: 40')
        expect(page).to have_content('Altura: 35')
        expect(page).to have_content('Largura: 45')
        expect(page).to have_content('Profundidade: 10')
        
        expect(page).to have_content('Nome Remetente: João da Silva')
        expect(page).to have_content('CPF Remetente: 62429965704')
        expect(page).to have_content('Email Remetente: silva@email.com')
        expect(page).to have_content('Telefone Remetente: 21 988975959')
        expect(page).to have_content('Endereço Remetente: Rua sem saida')
        expect(page).to have_content('Cidade Remetente: Rio de Janeiro')
        expect(page).to have_content('Estado Remetente: RJ')
        expect(page).to have_content('Cep Remetente: 22755-170')
        expect(page).to have_content('Nome Destinatario: Maria da Silva')
        expect(page).to have_content('CPF Destinatario: 62429965789')
        expect(page).to have_content('Email Destinatario: maria@email.com')
        expect(page).to have_content('Telefone Destinatario: 21 988972929')
        expect(page).to have_content('Endereço Destinatario: Rua com saida')
        expect(page).to have_content('Cidade Destinatario: Rio de Janeiro')
        expect(page).to have_content('Estado Destinatario: RJ')
        expect(page).to have_content('Cep Destinatario: 22755-200')
      
        expect(page).to have_content('Distancia: 959')
        expect(page).to have_content('Voltar') 
        expect(page).to have_content('Editar')    
    end

    it 'e edição sem sucesso, campos obrigatorios' do 

        #Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        order = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 1200, user_id: usuario.id,
            sender_name: 'Joaqui Severo', sender_identification: 12345678901, sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: 62429965704, recipient_email: 'lili@email.com', recipient_phone: '21988887676',
            recipient_address: 'Avenida Silçva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'
        click_on 'Editar'

        fill_in 'Codigo Produto', with: ''
        fill_in 'Peso', with: ''
        fill_in 'Altura', with: ''
        fill_in 'Largura', with: ''
        fill_in 'Profundidade', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Nome Remetente', with: ''
        fill_in 'CPF Remetente', with: ''
        fill_in 'Email Remetente', with: ''
        fill_in 'Telefone Remetente', with: ''
        fill_in 'Endereço Remetente', with: ''
        fill_in 'Cidade Remetente', with: ''
        fill_in 'Estado Remetente', with: ''
        fill_in 'Cep Remetente', with: ''
        fill_in 'Nome Destinatario', with: ''
        fill_in 'CPF Destinatario', with: ''
        fill_in 'Email Destinatario', with: ''
        fill_in 'Telefone Destinatario', with: ''
        fill_in 'Endereço Destinatario', with: ''
        fill_in 'Cidade Destinatario', with: ''
        fill_in 'Estado Destinatario', with: ''
        fill_in 'Cep Destinatario', with: '' 
        fill_in 'Distancia', with: ''  
        click_on 'Salvar'

        # Assert
        expect(page).to have_content('Ordem de Entrega NÃO atualizada !!!')
        expect(page).to have_content('Codigo Produto não pode ficar em branco')
        expect(page).to have_content('Peso não pode ficar em branco')
        expect(page).to have_content('Altura não pode ficar em branco')
        expect(page).to have_content('Largura não pode ficar em branco')
        expect(page).to have_content('Profundidade não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Nome Remetente não pode ficar em branco')
        expect(page).to have_content('CPF Remetente não pode ficar em branco')
        expect(page).to have_content('Email Remetente não pode ficar em branco')
        expect(page).to have_content('Telefone Remetente não pode ficar em branco')
        expect(page).to have_content('Endereço Remetente não pode ficar em branco')
        expect(page).to have_content('Cidade Remetente não pode ficar em branco')
        expect(page).to have_content('Estado Remetente não pode ficar em branco')
        expect(page).to have_content('Cep Remetente não pode ficar em branco')
        expect(page).to have_content('Nome Destinatario não pode ficar em branco')
        expect(page).to have_content('CPF Destinatario não pode ficar em branco')
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
        order = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 1200, user_id: usuario.id,
            sender_name: 'Joaqui Severo', sender_identification: 12345678901, sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: 62429965704, recipient_email: 'lili@email.com', recipient_phone: '21988887676',
            recipient_address: 'Avenida Silçva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'
        click_on 'Editar'
        
        click_on 'Cancelar'


        # Assert
        expect(current_path).to eq orders_path
        
    end



end