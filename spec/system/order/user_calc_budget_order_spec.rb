require 'rails_helper'

describe 'Usuario faz Orçamento' do

    it 'deve estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'e ve orçamentos da Ordem de entrega escolhida' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        usuario2 = User.create!(name: 'Saraiva', email: 'saraiva@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :active)

        deadline1 = Deadline.create!(start_distance:0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod1.id)
        deadline2 = Deadline.create!(start_distance:101, final_distance: 300, deadline_hours: 48,mode_transport_id: mod1.id)
        deadline3 = Deadline.create!(start_distance:301, final_distance: 1300, deadline_hours: 72, mode_transport_id: mod1.id)

        price1 = Price.create!(start_weight:0, final_weight: 100, km_price: 0.24, mode_transport_id: mod1.id)
        price2 = Price.create!(start_weight:101, final_weight: 300, km_price: 0.48,mode_transport_id: mod1.id)
        price3 = Price.create!(start_weight:301, final_weight: 600, km_price: 0.72, mode_transport_id: mod1.id)

        order = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 1200, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: 12345678901, sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: 62429965704, recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)
        

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'
        click_on 'Calcular Orçamento'

        
        # Assert
        expect(current_path).to eq budget_order_path(order.id)
        expect(page).not_to have_content('Não ha Ordem de Entrega para orçamento !!!')
        expect(page).to have_content('Joaquim Severo')
        expect(page).to have_content('12345678901')
        expect(page).to have_content('21 988975959')
        expect(page).to have_content('Rua São Siva, 100, Rubens Jardim - Macarena - AM - 45987-876')
        expect(page).to have_content('Lilian Monteiro')
        expect(page).to have_content('62429965704')
        expect(page).to have_content('21 988887676')
        expect(page).to have_content('Avenida Silva, 1200,São Roque - Mateuzinho - GO - 76987-345')

        expect(page).to have_content('Opções de Orçamento')

        expect(page).to have_content('Entrega Rapida')
        expect(page).to have_content(order.weight)
        expect(page).to have_content(order.distance)
        expect(page).to have_content('72 Hs')
        expect(page).to have_content('R$ 10,00')
        expect(page).to have_content('R$ 0,24')
        expect(page).to have_content('R$ ')
        expect(page).to butto_to('Aceitar')
        
        expect(page).to have_content('Sair')
    end

    it 'e contrata serviço de entrega' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        usuario2 = User.create!(name: 'Saraiva', email: 'saraiva@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :active)

        deadline1 = Deadline.create!(start_distance:0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod1.id)
        deadline2 = Deadline.create!(start_distance:101, final_distance: 300, deadline_hours: 48,mode_transport_id: mod1.id)
        deadline3 = Deadline.create!(start_distance:301, final_distance: 1300, deadline_hours: 72, mode_transport_id: mod1.id)

        price1 = Price.create!(start_weight:0, final_weight: 100, km_price: 0.24, mode_transport_id: mod1.id)
        price2 = Price.create!(start_weight:101, final_weight: 300, km_price: 0.48,mode_transport_id: mod1.id)
        price3 = Price.create!(start_weight:301, final_weight: 600, km_price: 0.72, mode_transport_id: mod1.id)

        order = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 1200, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: 12345678901, sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: 62429965704, recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)
        

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'
        click_on 'Calcular Orçamento'
        within("td#servico") do
            click_on 'Contratar Serviço'
        end

        
        # Assert
        expect(current_path).to eq budget_order_path(order.id)
        expect(page).not_to have_content("Serviço de entrega para ordem #{oder.code} contratado com sucesso !!!")
        
        expect(page).to have_content('Sair')
    end




end