require 'rails_helper'

describe 'Usuario consulta Orçamentos' do

    it 'deve estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end


    it 'e ve suas Ordens de Entrega não Iniciada' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        usuario2 = User.create!(name: 'Saraiva', email: 'saraiva@email.com', password: 'password')
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 1200, user_id: usuario.id,
            sender_name: 'Joaqui Severo', sender_identification: 48304423000121, sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: 62429965704, recipient_email: 'lili@email.com', recipient_phone: '21988887676',
            recipient_address: 'Avenida Silçva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)
        order2 = Order.create!(code: 'ZZZ1234567890ZZ', product_code: 'Produto_B', description: 'Produto  perecivel', 
                height: 25, width: 30, depth: 35, weight: 110, distance: 800, user_id: usuario2.id,
                sender_name: 'Clara Severo', sender_identification: 78498924022, sender_email: 'clara@email.com',
                sender_phone: '21 988976659', sender_address:'Rua Guilhermina, 300, Anil', sender_city: 'Diamantina', 
                sender_state: 'MG', sender_zipcode: '34987-834', recipient_name: 'Clariça Lins', 
                recipient_identification: 46280065049, recipient_email: 'lins@email.com', recipient_phone: '21 988885467',
                recipient_address: 'Rua Mariz Barros, 10/403, São Roque', recipient_city: 'Mateuzinho', recipient_state: 'RD', 
                recipient_zipcode: '89987-398', status: :pending)

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'


        # Assert
        expect(current_path).to eq orders_path
        expect(page).not_to have_content('Não ha Ordem de Entrega para orçamento !!!')
        expect(page).to have_content("#{order1.code}")
        expect(page).to have_content('Produto_A')
        expect(page).to have_content('10')
        expect(page).to have_content('1200')
        expect(page).to have_content('Pendente')
        expect(page).to have_content('Sair')
    end

    it 'e  Não ha Ordem de Entrega para orçamento' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        usuario2 = User.create!(name: 'Saraiva', email: 'saraiva@email.com', password: 'password')
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 1200, user_id: usuario2.id,
            sender_name: 'Joaqui Severo', sender_identification: 48304423000121, sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: 62429965704, recipient_email: 'lili@email.com', recipient_phone: '21988887676',
            recipient_address: 'Avenida Silçva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)
        order2 = Order.create!(code: 'ZZZ1234567890ZZ', product_code: 'Produto_B', description: 'Produto  perecivel', 
                height: 25, width: 30, depth: 35, weight: 110, distance: 800, user_id: usuario2.id,
                sender_name: 'Clara Severo', sender_identification: 78498924022, sender_email: 'clara@email.com',
                sender_phone: '21 988976659', sender_address:'Rua Guilhermina, 300, Anil', sender_city: 'Diamantina', 
                sender_state: 'MG', sender_zipcode: '34987-834', recipient_name: 'Clariça Lins', 
                recipient_identification: 46280065049, recipient_email: 'lins@email.com', recipient_phone: '21 988885467',
                recipient_address: 'Rua Mariz Barros, 10/403, São Roque', recipient_city: 'Mateuzinho', recipient_state: 'RD', 
                recipient_zipcode: '89987-398', status: :pending)

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'


        # Assert
        expect(current_path).to eq orders_path
        expect(page).to have_content('Não ha Ordem de Entrega para orçamento !!!')
        expect(page).not_to have_content("#{order1.code}")
        expect(page).not_to have_content('Produto_A')
        expect(page).not_to have_content('10')
        expect(page).not_to have_content('1200')
        expect(page).not_to have_content('Pendente')
        expect(page).to have_content('Sair')
    end



end
