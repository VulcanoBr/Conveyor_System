require 'rails_helper'

describe 'Usuario encerra entrega' do
    
    it 'deve estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'e ve relação de ordens de entrega' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :active)
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: "25.446.403/0001-90", sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :in_delivery)

        order2 = Order.create!(code: 'MMM1234567890MM', product_code: 'Produto_B', description: 'Produto inflamavel', 
            height: 35, width: 40, depth: 35, weight: 50, distance: 750, user_id: usuario.id,
            sender_name: 'Maria Albulquerque', sender_identification: "784.989.240-22", sender_email: 'maria@email.com',
            sender_phone: '51 988975951', sender_address: 'Rua Me Xama, 305/102, Coronel Almeida', sender_city: 'Carolandia', 
            sender_state: 'BA', sender_zipcode: '55987-678', recipient_name: 'Raimunda Lopes Silva', 
            recipient_identification: "462.800.650-49", recipient_email: 'lopes@email.com', recipient_phone: '35 945347676',
            recipient_address: 'Rua da Mirella, 5 fundos, Jaguara Norte', recipient_city: 'Xingu Nova', recipient_state: 'RO', 
            recipient_zipcode: '86956-366', status: :in_delivery)

        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        
        dvo1 = DeliveryOrder.create!(code: 'XXX1234567890XX', deadline_hours: '98', delivery_fee: '50',
           km_price: '10', amount: '23', delivery_forecast: Date.today + 5, delivery_date: Date.today + 4, delivery_reason:'xxxx',
            status: :in_delivery, closure_status: :closed_on_time, order_id: order1.id, mode_transport_id: mod1.id, 
            vehicle_id: vehicle2.id, created_at: Date.today)

        dvo2 = DeliveryOrder.create!(code: 'MMM1234567890MM', deadline_hours: '240', delivery_fee: '130',
                km_price: '30', amount: '15050', delivery_forecast: Date.today + 8, delivery_date: Date.today + 8, delivery_reason:'',
                 status: :in_delivery, closure_status: :closed_on_time, order_id: order2.id, mode_transport_id: mod1.id, 
                 vehicle_id: vehicle1.id, created_at: Date.today)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        
        click_on 'Encerrar Ordem de Entrega' 

        #Assert
        expect(current_path).to eq delivery_order_index_path

        expect(page).to have_content("Relação Ordem de Entrega")
        expect(page).to have_content('XXX1234567890XX')
        expect(page).to have_content(I18n.localize(Date.today + 5))
        expect(page).to have_content('Em Entrega')

        expect(page).to have_content('MMM1234567890MM')
        expect(page).to have_content(I18n.localize(Date.today + 8))
        expect(page).to have_content('Em Entrega')

        expect(page).not_to have_content('Não ha Ordem de Entrega !!!')

        expect(page).to have_content('Sair')


    end

    it ' e click botão encerrar' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :active)
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: "25.446.403/0001-90", sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :in_delivery)

        order2 = Order.create!(code: 'MMM1234567890MM', product_code: 'Produto_B', description: 'Produto inflamavel', 
            height: 35, width: 40, depth: 35, weight: 50, distance: 750, user_id: usuario.id,
            sender_name: 'Maria Albulquerque', sender_identification: "784.989.240-22", sender_email: 'maria@email.com',
            sender_phone: '51 988975951', sender_address: 'Rua Me Xama, 305/102, Coronel Almeida', sender_city: 'Carolandia', 
            sender_state: 'BA', sender_zipcode: '55987-678', recipient_name: 'Raimunda Lopes Silva', 
            recipient_identification: "462.800.650-49", recipient_email: 'lopes@email.com', recipient_phone: '35 945347676',
            recipient_address: 'Rua da Mirella, 5 fundos, Jaguara Norte', recipient_city: 'Xingu Nova', recipient_state: 'RO', 
            recipient_zipcode: '86956-366', status: :in_delivery)

        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        
        dvo1 = DeliveryOrder.create!(code: 'XXX1234567890XX', deadline_hours: '98', delivery_fee: '50',
           km_price: '10', amount: '23', delivery_forecast: Date.today + 5, delivery_date: Date.today + 4, delivery_reason:'xxxx',
            status: :in_delivery, closure_status: :closed_on_time, order_id: order1.id, mode_transport_id: mod1.id, 
            vehicle_id: vehicle2.id, created_at: Date.today)
        dvo2 = DeliveryOrder.create!(code: 'MMM1234567890MM', deadline_hours: '240', delivery_fee: '130', 
            km_price: '30', amount: '15050', delivery_forecast: Date.today + 8, delivery_date: Date.today + 8, 
            delivery_reason:'',  status: :in_delivery, closure_status: :closed_on_time, order_id: order2.id, 
            mode_transport_id: mod1.id, vehicle_id: vehicle1.id, created_at: Date.today)
        
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        
        click_on 'Encerrar Ordem de Entrega' 
        within('td', id:'delivery_order_1') do
            click_on  'Encerrar' 
        end

        #Assert
        expect(current_path).to eq edit_delivery_order_path(dvo1.id)

        expect(page).to have_content("Encerrar Ordem de Entrega")
        expect(page).to have_content('Codigo do Pedido: XXX1234567890XX')
        expect(page).to have_content("Previsão de Entrega: #{I18n.localize(Date.today + 5)}")
        expect(page).to have_content('Status: Em Entrega')

        expect(page).to have_field('Data da Entrega')
        expect(page).to have_field('Status de Encerramento')
        expect(page).to have_field('Motivo do Atraso')

        expect(page).to have_content('Sair')


    end

    it ' e encerra dentro do prazo' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :active)
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: "25.446.403/0001-90", sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :in_delivery)

        order2 = Order.create!(code: 'MMM1234567890MM', product_code: 'Produto_B', description: 'Produto inflamavel', 
            height: 35, width: 40, depth: 35, weight: 50, distance: 750, user_id: usuario.id,
            sender_name: 'Maria Albulquerque', sender_identification: "784.989.240-22", sender_email: 'maria@email.com',
            sender_phone: '51 988975951', sender_address: 'Rua Me Xama, 305/102, Coronel Almeida', sender_city: 'Carolandia', 
            sender_state: 'BA', sender_zipcode: '55987-678', recipient_name: 'Raimunda Lopes Silva', 
            recipient_identification: "462.800.650-49", recipient_email: 'lopes@email.com', recipient_phone: '35 945347676',
            recipient_address: 'Rua da Mirella, 5 fundos, Jaguara Norte', recipient_city: 'Xingu Nova', recipient_state: 'RO', 
            recipient_zipcode: '86956-366', status: :in_delivery)

        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        
        dvo1 = DeliveryOrder.create!(code: 'XXX1234567890XX', deadline_hours: '98', delivery_fee: '50',
           km_price: '10', amount: '1030', delivery_forecast: Date.today + 5, delivery_date: Date.today + 4, delivery_reason:'xxxx',
            status: :in_delivery, closure_status: :closed_on_time, order_id: order1.id, mode_transport_id: mod1.id, 
            vehicle_id: vehicle2.id, created_at: Date.today)
        dvo2 = DeliveryOrder.create!(code: 'MMM1234567890MM', deadline_hours: '240', delivery_fee: '130', 
            km_price: '30', amount: '15050', delivery_forecast: Date.today + 8, delivery_date: Date.today + 8, 
            delivery_reason:'',  status: :in_delivery, closure_status: :closed_on_time, order_id: order2.id, 
            mode_transport_id: mod1.id, vehicle_id: vehicle1.id, created_at: Date.today)
        
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        
        click_on 'Encerrar Ordem de Entrega' 
        within('td', id:'delivery_order_1') do
            click_on  'Encerrar' 
        end
        
        fill_in 'Data da Entrega', with: Date.today + 4
        select 'Closed on time', from: 'Status de Encerramento'
        fill_in 'Motivo do Atraso', with: ''

        click_on 'Salvar'
       

        #Assert
        expect(current_path).to eq closed_budget_delivery_order_index_path

        expect(page).to have_content('Ordem de Entrega encerrada com sucesso!!!')
        expect(page).to have_content('Serviço Encerrado')
        expect(page).to have_content("Codigo do Pedido: XXX1234567890XX")
        expect(page).to have_content('Modalidade: Entrega Rapida')
        expect(page).to have_content('Estimativa de Entrega: 98 Hs')
        expect(page).to have_content('Valor Total: R$ 1.030,00')
        expect(page).to have_content("Previsão de Entrega: #{I18n.localize(Date.today + 5)}")
        #expect(page).to have_content('Status: Em Entrega')

        expect(page).to have_content("Data da Entrega: #{I18n.localize(Date.today + 4)}")
        expect(page).to have_content('Status de Encerramento: Encerrado no prazo')
        expect(page).not_to have_content('Motivo do Atraso')

        expect(page).to have_content('Sair')


    end

    it ' e encerra depois do prazo' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :active)
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: "25.446.403/0001-90", sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :in_delivery)

        order2 = Order.create!(code: 'MMM1234567890MM', product_code: 'Produto_B', description: 'Produto inflamavel', 
            height: 35, width: 40, depth: 35, weight: 50, distance: 750, user_id: usuario.id,
            sender_name: 'Maria Albulquerque', sender_identification: "784.989.240-22", sender_email: 'maria@email.com',
            sender_phone: '51 988975951', sender_address: 'Rua Me Xama, 305/102, Coronel Almeida', sender_city: 'Carolandia', 
            sender_state: 'BA', sender_zipcode: '55987-678', recipient_name: 'Raimunda Lopes Silva', 
            recipient_identification: "462.800.650-49", recipient_email: 'lopes@email.com', recipient_phone: '35 945347676',
            recipient_address: 'Rua da Mirella, 5 fundos, Jaguara Norte', recipient_city: 'Xingu Nova', recipient_state: 'RO', 
            recipient_zipcode: '86956-366', status: :in_delivery)

        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        
        dvo1 = DeliveryOrder.create!(code: 'XXX1234567890XX', deadline_hours: '98', delivery_fee: '50',
           km_price: '10', amount: '1030', delivery_forecast: Date.today + 1, delivery_date:  Date.today + 4, delivery_reason:'xxxx',
            status: :in_delivery, closure_status: :closed_on_time, order_id: order1.id, mode_transport_id: mod1.id, 
            vehicle_id: vehicle2.id, created_at: Date.today)
        dvo2 = DeliveryOrder.create!(code: 'MMM1234567890MM', deadline_hours: '240', delivery_fee: '130', 
            km_price: '30', amount: '15050', delivery_forecast: Date.today + 5, delivery_date: Date.today + 6, 
            delivery_reason:'',  status: :in_delivery, closure_status: :closed_on_time, order_id: order2.id, 
            mode_transport_id: mod1.id, vehicle_id: vehicle1.id, created_at: Date.today)
        
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        
        click_on 'Encerrar Ordem de Entrega' 
        within('td', id:'delivery_order_1') do
            click_on  'Encerrar' 
        end
        
        fill_in 'Data da Entrega', with: Date.today + 6
        select 'Closed on time', from: 'Status de Encerramento'
        fill_in 'Motivo do Atraso', with: 'Veiculo com defeito'

        click_on 'Salvar'
       

        #Assert
        expect(current_path).to eq closed_budget_delivery_order_index_path

        expect(page).to have_content('Ordem de Entrega encerrada com sucesso!!!')
        expect(page).to have_content('Serviço Encerrado')
        expect(page).to have_content("Codigo do Pedido: XXX1234567890XX")
        expect(page).to have_content('Modalidade: Entrega Rapida')
        expect(page).to have_content('Estimativa de Entrega: 98 Hs')
        expect(page).to have_content('Taxa de Entrega: R$ 50,00')
        expect(page).to have_content('Valor Total: R$ 1.030,00')
        expect(page).to have_content("Previsão de Entrega: #{I18n.localize(Date.today + 1)}")
        

        expect(page).to have_content("Data da Entrega: #{I18n.localize(Date.today + 6)}")
        expect(page).to have_content('Status de Encerramento: Encerrado no prazo')
        expect(page).to have_content('Motivo do Atraso: Veiculo com defeito')
        #expect(page).to have_content('Status: Em Entrega')

        expect(page).to have_content('Sair')


    end

    it 'e encerra sem sucesso campos obrigatorios' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :active)
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: "25.446.403/0001-90", sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :in_delivery)

        order2 = Order.create!(code: 'MMM1234567890MM', product_code: 'Produto_B', description: 'Produto inflamavel', 
            height: 35, width: 40, depth: 35, weight: 50, distance: 750, user_id: usuario.id,
            sender_name: 'Maria Albulquerque', sender_identification: "784.989.240-22", sender_email: 'maria@email.com',
            sender_phone: '51 988975951', sender_address: 'Rua Me Xama, 305/102, Coronel Almeida', sender_city: 'Carolandia', 
            sender_state: 'BA', sender_zipcode: '55987-678', recipient_name: 'Raimunda Lopes Silva', 
            recipient_identification: "462.800.650-49", recipient_email: 'lopes@email.com', recipient_phone: '35 945347676',
            recipient_address: 'Rua da Mirella, 5 fundos, Jaguara Norte', recipient_city: 'Xingu Nova', recipient_state: 'RO', 
            recipient_zipcode: '86956-366', status: :in_delivery)

        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        
        dvo1 = DeliveryOrder.create!(code: 'XXX1234567890XX', deadline_hours: '98', delivery_fee: '50',
           km_price: '10', amount: '1030', delivery_forecast: Date.today + 1, delivery_date: Date.today + 2, delivery_reason:'XXX',
            status: :in_delivery, closure_status: :closed_on_time, order_id: order1.id, mode_transport_id: mod1.id, 
            vehicle_id: vehicle2.id, created_at: Date.today)
        dvo2 = DeliveryOrder.create!(code: 'MMM1234567890MM', deadline_hours: '240', delivery_fee: '130', 
            km_price: '30', amount: '15050', delivery_forecast: Date.today + 5, delivery_date: Date.today + 6, 
            delivery_reason:'xxx',  status: :in_delivery, closure_status: :closed_late, order_id: order2.id, 
            mode_transport_id: mod1.id, vehicle_id: vehicle1.id, created_at: Date.today)
        delivery_order = DeliveryOrder.find(dvo1.id)
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        
        click_on 'Encerrar Ordem de Entrega' 
        within('td', id:'delivery_order_1') do
            click_on  'Encerrar' 
        end
        
        fill_in 'Data da Entrega', with: ''
        select 'Selecione o status de encerramento', from: 'Status de Encerramento'
        page.has_select?('Status de Encerramento', selected: 'Closed late')
        fill_in 'Motivo do Atraso', with: ''

        click_on 'Salvar'
       

        #Assert
        #expect(current_path).to eq edit_delivery_order_path(delivery_order)

        expect(page).to have_content('Ordem de Entrega NÃO encerrada !!!')
        expect(page).to have_content('Data da Entrega não pode ficar em branco')
        expect(page).to have_content('Status de Encerramento não pode ficar em branco')
    #    expect(page).to have_content('Motivo do Atraso não pode ficar em branco')

        expect(page).to have_content('Cancelar')
    end

    it 'e cancela encerramento ' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
                minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                    minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :active)
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
                height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
                sender_name: 'Joaquim Severo', sender_identification: "25.446.403/0001-90", sender_email: 'joaquim@email.com',
                sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
                sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
                recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
                recipient_address: 'Avenida Silva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
                recipient_zipcode: '76987-345', status: :in_delivery)
    
        order2 = Order.create!(code: 'MMM1234567890MM', product_code: 'Produto_B', description: 'Produto inflamavel', 
                height: 35, width: 40, depth: 35, weight: 50, distance: 750, user_id: usuario.id,
                sender_name: 'Maria Albulquerque', sender_identification: "784.989.240-22", sender_email: 'maria@email.com',
                sender_phone: '51 988975951', sender_address: 'Rua Me Xama, 305/102, Coronel Almeida', sender_city: 'Carolandia', 
                sender_state: 'BA', sender_zipcode: '55987-678', recipient_name: 'Raimunda Lopes Silva', 
                recipient_identification: "462.800.650-49", recipient_email: 'lopes@email.com', recipient_phone: '35 945347676',
                recipient_address: 'Rua da Mirella, 5 fundos, Jaguara Norte', recipient_city: 'Xingu Nova', recipient_state: 'RO', 
                recipient_zipcode: '86956-366', status: :in_delivery)
    
        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                        year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                            year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        dvo1 = DeliveryOrder.create!(code: 'XXX1234567890XX', deadline_hours: '98', delivery_fee: '50',
                    km_price: '10', amount: '1030', delivery_forecast: Date.today + 1, delivery_date: Date.today + 5, 
                    delivery_reason:'xxxx', status: :in_delivery, closure_status: :closed_on_time, order_id: order1.id, 
                    mode_transport_id: mod1.id, vehicle_id: vehicle2.id, created_at: Date.today)
        dvo2 = DeliveryOrder.create!(code: 'MMM1234567890MM', deadline_hours: '240', delivery_fee: '130', 
                    km_price: '30', amount: '15050', delivery_forecast: Date.today + 5, delivery_date: Date.today + 5, 
                    delivery_reason:'xxxxx',  status: :in_delivery, closure_status: :closed_late, order_id: order2.id, 
                    mode_transport_id: mod1.id, vehicle_id: vehicle1.id, created_at: Date.today)    
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        
        click_on 'Encerrar Ordem de Entrega' 
        within('td', id:'delivery_order_1') do
            click_on  'Encerrar' 
        end
        
        click_on 'Cancelar'

        # Assert
        expect(current_path).to eq delivery_order_index_path
        
    end


end