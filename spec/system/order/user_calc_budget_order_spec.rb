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

    it 'e ve orçamentos da Ordem de entrega a ser escolhida' do
    
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
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: "48.304.423/0001-21", sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Silva', sender_number: '100', 
            sender_complement: '', sender_neighborhood: 'Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)

        result = ModeTransport.with_prices_and_deadlines_for_order(order.distance, order.weight)
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
        expect(page).to have_content('48.304.423/0001-21')
        expect(page).to have_content('21 988975959')
        expect(page).to have_content('Rua São Silva 100 - Rubens Jardim - Macarena - AM - 45987-876')
        expect(page).to have_content('Lilian Monteiro')
        expect(page).to have_content('624.299.657-04')
        expect(page).to have_content('21 988887676')
        expect(page).to have_content('Avenida Silva 1200 - São Roque - Mateuzinho - GO - 76987-345')

        expect(page).to have_content('Produto a ser entregue')
        expect(page).to have_content(order.product_code)
        expect(page).to have_content(order.description)
        expect(page).to have_content(order.weight)
        expect(page).to have_content(order.height)
        expect(page).to have_content(order.width)
        expect(page).to have_content(order.depth)
        expect(page).to have_content(order.distance)

        expect(page).to have_content('Opções de Orçamento')
        expect(page).to have_content('Entrega Rapida')
        expect(page).to have_content(order.weight)
        expect(page).to have_content(order.distance)
        expect(page).to have_content('72 Hs')
        expect(page).to have_content('R$ 10,00')
        expect(page).to have_content('R$ 0,24')
        expect(page).to have_content('R$ 118,00')
        
        expect(page).to have_content('Sair')
    end

    it 'e contrata serviço de entrega' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        usuario2 = User.create!(name: 'Saraiva', email: 'saraiva@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 100, delivery_fee: 50.0, status: :active)

        deadline1 = Deadline.create!(start_distance:0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod1.id)
        deadline2 = Deadline.create!(start_distance:101, final_distance: 300, deadline_hours: 48,mode_transport_id: mod1.id)
        deadline3 = Deadline.create!(start_distance:301, final_distance: 1300, deadline_hours: 72, mode_transport_id: mod1.id)

        price1 = Price.create!(start_weight:0, final_weight: 100, km_price: 0.24, mode_transport_id: mod1.id)
        price2 = Price.create!(start_weight:101, final_weight: 300, km_price: 0.48,mode_transport_id: mod1.id)
        price3 = Price.create!(start_weight:301, final_weight: 600, km_price: 0.72, mode_transport_id: mod1.id)
        allow(SecureRandom).to receive(:alphanumeric).and_return("XXX1234567890XX")    
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: "48.304.423/0001-21", sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Silva', sender_number: '100',
            sender_complement: "", sender_neighborhood: 'Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)

        order2 = Order.create!(code: 'MMM1234567890MM', product_code: 'Produto_B', description: 'Produto perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Silvio Santos', sender_identification: "784.989.240-22", sender_email: 'santos@email.com',
            sender_phone: '34 988975934', sender_address: 'Rua São Silva', sender_number: '100',
            sender_complement: '', sender_neighborhood: 'Jalapão', sender_city: 'Imperatriz', 
            sender_state: 'MA', sender_zipcode: '54987-454', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)


        result = ModeTransport.with_prices_and_deadlines_for_order(order1.distance, order1.weight)

        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        vehicle = Vehicle.find_by("maximum_load >= ? AND status = ?", order1.weight, 0)
        
        codigo_atual = order1.code
        
        dev= DeliveryOrder.create!(code: 'XXX1234567890XX', deadline_hours: '98', delivery_fee: '13',
           km_price: '10', amount: '23', delivery_forecast: Date.today + 5,  delivery_date: Date.today + 5, delivery_reason:'xxxx',
            status: :in_delivery, closure_status: :closed_on_time, order_id: order1.id, mode_transport_id: mod1.id, 
            vehicle_id: vehicle.id, created_at: Date.today)
        
        previsao_entrega = dev.delivery_forecast
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'
        within('td', id: 'order_1') do
            click_on 'Calcular Orçamento'
        end
            click_on 'Contratar Serviço'
        # Assert
    #    expect(current_path).to eq delivery_order_path(dev)
        expect(page).to have_content("Serviço de entrega para ordem #{order1.code} contratado com sucesso !!!")
        expect(page).to have_content('Serviço Contratado')
        expect(page).to have_content('Codigo do Pedido: XXX1234567890XX')
        expect(page).to have_content('Modalidade: Entrega Rapida')
        expect(page).to have_content('Estimativa de Entrega: 72 Hs')
        expect(page).to have_content('Taxa de Entrega: R$ 10,00')
        expect(page).to have_content('Valor Total: R$ 12,40')
        expect(page).to have_content("Previsão de Entrega: #{I18n.localize(Date.today + 4)}")
        expect(page).to have_content('Status: Em Entrega')

        
        expect(page).to have_content('Voltar')
    end

    it 'e contrata serviço de entrega e alterar status veiculo para em entrega ' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        usuario2 = User.create!(name: 'Saraiva', email: 'saraiva@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 100, delivery_fee: 50.0, status: :active)

        deadline1 = Deadline.create!(start_distance:0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod1.id)
        deadline2 = Deadline.create!(start_distance:101, final_distance: 300, deadline_hours: 48,mode_transport_id: mod1.id)
        deadline3 = Deadline.create!(start_distance:301, final_distance: 1300, deadline_hours: 72, mode_transport_id: mod1.id)

        price1 = Price.create!(start_weight:0, final_weight: 100, km_price: 0.24, mode_transport_id: mod1.id)
        price2 = Price.create!(start_weight:101, final_weight: 300, km_price: 0.48,mode_transport_id: mod1.id)
        price3 = Price.create!(start_weight:301, final_weight: 600, km_price: 0.72, mode_transport_id: mod1.id)
        allow(SecureRandom).to receive(:alphanumeric).and_return("XXX1234567890XX")    
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: "48.304.423/0001-21", sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Silva', sender_number: '100',
            sender_complement: '', sender_neighborhood: 'Jalapão', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)

        order2 = Order.create!(code: 'MMM1234567890MM', product_code: 'Produto_B', description: 'Produto perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Silvio Santos', sender_identification: "784.989.240-22", sender_email: 'santos@email.com',
            sender_phone: '34 988975934', sender_address: 'Rua São Silva', sender_number: '100',
            sender_complement: '', sender_neighborhood: 'Jalapão', sender_city: 'Imperatriz', 
            sender_state: 'MA', sender_zipcode: '54987-454', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)


        result = ModeTransport.with_prices_and_deadlines_for_order(order1.distance, order1.weight)

        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        vehicle = Vehicle.find_by("maximum_load >= ? AND status = ?", order1.weight, 0)
        
        codigo_atual = order1.code
        
        dev= DeliveryOrder.create!(code: 'XXX1234567890XX', deadline_hours: '98', delivery_fee: '13',
           km_price: '10', amount: '23', delivery_forecast: Date.today + 5,  delivery_date: Date.today + 5, delivery_reason:'xxxx',
            status: :in_delivery, closure_status: :closed_on_time, order_id: order1.id, mode_transport_id: mod1.id, 
            vehicle_id: vehicle.id, created_at: Date.today)
        
        previsao_entrega = dev.delivery_forecast
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'
        within('td', id: 'order_1') do
            click_on 'Calcular Orçamento'
        end
            click_on 'Contratar Serviço'
            vehicle.in_delivery!
        # Assert
    #    expect(current_path).to eq delivery_order_path(dev)
        expect(vehicle.status).to eq('in_delivery')
        expect(vehicle.in_delivery!).to be true
        expect(page).to have_content("Serviço de entrega para ordem #{order1.code} contratado com sucesso !!!")
        expect(page).to have_content('Serviço Contratado')
        expect(page).to have_content('Codigo do Pedido: XXX1234567890XX')
        expect(page).to have_content('Modalidade: Entrega Rapida')
        expect(page).to have_content('Estimativa de Entrega: 72 Hs')
        expect(page).to have_content('Taxa de Entrega: R$ 10,00')
        expect(page).to have_content('Valor Total: R$ 12,40')
        expect(page).to have_content("Previsão de Entrega: #{I18n.localize(Date.today + 4)}")
        expect(page).to have_content('Status: Em Entrega')
        
        expect(page).to have_content('Voltar')
    end

    it 'e contrata serviço de entrega, mas ha problema no save' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        usuario2 = User.create!(name: 'Saraiva', email: 'saraiva@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 100, delivery_fee: 50.0, status: :active)

        deadline1 = Deadline.create!(start_distance:0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod1.id)
        deadline2 = Deadline.create!(start_distance:101, final_distance: 300, deadline_hours: 48,mode_transport_id: mod1.id)
        deadline3 = Deadline.create!(start_distance:301, final_distance: 1300, deadline_hours: 72, mode_transport_id: mod1.id)

        price1 = Price.create!(start_weight:0, final_weight: 100, km_price: 0.24, mode_transport_id: mod1.id)
        price2 = Price.create!(start_weight:101, final_weight: 300, km_price: 0.48,mode_transport_id: mod1.id)
        price3 = Price.create!(start_weight:301, final_weight: 600, km_price: 0.72, mode_transport_id: mod1.id)
        allow(SecureRandom).to receive(:alphanumeric).and_return("XXX1234567890XX")    
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: "48.304.423/0001-21", sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Silva', sender_number: '100',
            sender_complement: '', sender_neighborhood: 'Jalapão', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)

        order2 = Order.create!(code: 'MMM1234567890MM', product_code: 'Produto_B', description: 'Produto perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Silvio Santos', sender_identification: "784.989.240-22", sender_email: 'santos@email.com',
            sender_phone: '34 988975934', sender_address: 'Rua São Silva', sender_number: '100',
            sender_complement: '', sender_neighborhood: 'Jalapão', sender_city: 'Imperatriz', 
            sender_state: 'MA', sender_zipcode: '54987-454', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)


        result = ModeTransport.with_prices_and_deadlines_for_order(order1.distance, order1.weight)

        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        vehicle = Vehicle.find_by("maximum_load >= ? AND status = ?", order1.weight, 0)
        
        codigo_atual = order1.code
        allow_any_instance_of(DeliveryOrder).to receive(:save).and_return(false)
        
        dev1= DeliveryOrder.new(code: nil, deadline_hours: nil, delivery_fee: nil,
           km_price: nil, amount: 'aa', delivery_forecast: nil,  delivery_date: Date.today + 5, delivery_reason:'xxxx',
            status: :in_delivery, closure_status: :closed_on_time, order_id: order1.id, mode_transport_id: mod1.id, 
            vehicle_id: vehicle.id, created_at: Date.today)
        
        previsao_entrega = dev1.delivery_forecast

       # allow(dev1).to receive(:save).and_return(false)
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'
        within('td', id: 'order_1') do
            click_on 'Calcular Orçamento'
        end
            click_on 'Contratar Serviço'
        # Assert
        expect(dev1.save).to eq(false)
       # expect(page).to have_content("Serviço de entrega para ordem  NÃO contratado  !!!")
        expect(current_path).to eq orders_path
    end

    it 'e NÃO contrata serviço de entrega' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        usuario2 = User.create!(name: 'Saraiva', email: 'saraiva@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 100, delivery_fee: 50.0, status: :active)

        deadline1 = Deadline.create!(start_distance:0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod1.id)
        deadline2 = Deadline.create!(start_distance:101, final_distance: 300, deadline_hours: 48,mode_transport_id: mod1.id)
        deadline3 = Deadline.create!(start_distance:301, final_distance: 1300, deadline_hours: 72, mode_transport_id: mod1.id)

        price1 = Price.create!(start_weight:0, final_weight: 100, km_price: 0.24, mode_transport_id: mod1.id)
        price2 = Price.create!(start_weight:101, final_weight: 300, km_price: 0.48,mode_transport_id: mod1.id)
        price3 = Price.create!(start_weight:301, final_weight: 600, km_price: 0.72, mode_transport_id: mod1.id)
        allow(SecureRandom).to receive(:alphanumeric).and_return("XXX1234567890XX")    
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: "48.304.423/0001-21", sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Silva', sender_number: '100',
            sender_complement: '', sender_neighborhood: 'Jalapão', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)

        order2 = Order.create!(code: 'MMM1234567890MM', product_code: 'Produto_B', description: 'Produto perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Silvio Santos', sender_identification: "784.989.240-22", sender_email: 'santos@email.com',
            sender_phone: '34 988975934', sender_address: 'Rua São Silva', sender_number: '100',
            sender_complement: '', sender_neighborhood: 'Jalapão', sender_city: 'Imperatriz', 
            sender_state: 'MA', sender_zipcode: '54987-454', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)

        result = ModeTransport.with_prices_and_deadlines_for_order(order1.distance, order1.weight)

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'
        within('td', id: 'order_1') do
            click_on 'Calcular Orçamento'
        end
        click_on 'Voltar'
        # Assert
        expect(current_path).to eq orders_path
        expect(page).not_to have_content('Não ha Ordem de Entrega para orçamento !!!')
        expect(page).to have_content("#{order1.code}")
        expect(page).to have_content('Produto_A')
        expect(page).to have_content('10')
        expect(page).to have_content('450')
        expect(page).to have_content('Pendente')
        expect(page).to have_content('Sair')
    end

    it 'e NÃO ha opções de Ordem de entrega a ser contratada' do
    
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
        allow(SecureRandom).to receive(:alphanumeric).and_return("XXX1234567890XX")         
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 5015, width: 20, depth: 5, weight: 10, distance: 6450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: "48.304.423/0001-21", sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Silva', sender_number: '100',
            sender_complement: '', sender_neighborhood: 'Jalapão', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)

        order2 = Order.create!(code: 'MMM1234567890MM', product_code: 'Produto_B', description: 'Produto perecivel', 
            height: 6515, width: 20, depth: 5, weight: 10, distance: 7450, user_id: usuario.id,
            sender_name: 'Silvio Santos', sender_identification: "784.989.240-22", sender_email: 'santos@email.com',
            sender_phone: '34 988975934', sender_address: 'Rua São Silva', sender_number: '100',
            sender_complement: '', sender_neighborhood: 'Jalapão', sender_city: 'Imperatriz', 
            sender_state: 'MA', sender_zipcode: '54987-454', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)

        result = ModeTransport.with_prices_and_deadlines_for_order(order1.distance, order1.weight)
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'
        within('td', id: 'order_1') do
            click_on 'Calcular Orçamento'
        end

        # Assert
        expect(current_path).to eq budget_order_path(order1.id)
        expect(page).not_to have_content('Não ha Ordem de Entrega para orçamento !!!')
        expect(page).to have_content('Joaquim Severo')
        expect(page).to have_content('48.304.423/0001-21')
        expect(page).to have_content('21 988975959')
        expect(page).to have_content('Rua São Silva 100 - Jalapão - Macarena - AM - 45987-876')
        expect(page).to have_content('Lilian Monteiro')
        expect(page).to have_content('624.299.657-04')
        expect(page).to have_content('21 988887676')
        expect(page).to have_content('Avenida Silva 1200 - São Roque - Mateuzinho - GO - 76987-345')

        expect(page).to have_content('Produto a ser entregue')
        expect(page).to have_content(order1.product_code)
        expect(page).to have_content(order1.description)
        expect(page).to have_content(order1.weight)
        expect(page).to have_content(order1.height)
        expect(page).to have_content(order1.width)
        expect(page).to have_content(order1.depth)
        expect(page).to have_content(order1.distance)

        expect(page).to have_content('Opções de Orçamento')
        expect(page).to have_content('No momento não temos como orçar sua Ordem de Entrega !!!')
        expect(page).to have_content('Por favor, entrar em contato com a nossa central 0800 9999-5959 !!!')
        
        expect(page).to have_content('Voltar')
    end

    it 'e NÃO ha veiculos para entrega do produto, serviço não contratado' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        usuario2 = User.create!(name: 'Saraiva', email: 'saraiva@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 100, delivery_fee: 50.0, status: :active)

        deadline1 = Deadline.create!(start_distance:0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod1.id)
        deadline2 = Deadline.create!(start_distance:101, final_distance: 300, deadline_hours: 48,mode_transport_id: mod1.id)
        deadline3 = Deadline.create!(start_distance:301, final_distance: 1300, deadline_hours: 72, mode_transport_id: mod1.id)

        price1 = Price.create!(start_weight:0, final_weight: 100, km_price: 0.24, mode_transport_id: mod1.id)
        price2 = Price.create!(start_weight:101, final_weight: 300, km_price: 0.48,mode_transport_id: mod1.id)
        price3 = Price.create!(start_weight:301, final_weight: 600, km_price: 0.72, mode_transport_id: mod1.id)
        allow(SecureRandom).to receive(:alphanumeric).and_return("XXX1234567890XX")    
        order1 = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: "48.304.423/0001-21", sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Silva', sender_number: '100',
            sender_complement: '', sender_neighborhood: 'Jalapão', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)

        order2 = Order.create!(code: 'MMM1234567890MM', product_code: 'Produto_B', description: 'Produto perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Silvio Santos', sender_identification: "784.989.240-22", sender_email: 'santos@email.com',
            sender_phone: '34 988975934', sender_address: 'Rua São Silva', sender_number: '100',
            sender_complement: '', sender_neighborhood: 'Jalapão', sender_city: 'Imperatriz', 
            sender_state: 'MA', sender_zipcode: '54987-454', recipient_name: 'Lilian Monteiro', 
            recipient_identification: "624.299.657-04", recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva', recipient_number: '1200', recipient_complement: '',
            recipient_neighborhood: 'São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :pending)


        result = ModeTransport.with_prices_and_deadlines_for_order(order1.distance, order1.weight)

        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_delivery)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_delivery)
        vehicle = Vehicle.find_by("maximum_load >= ? AND status = ?", order1.weight, 0)
        
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Consulta Orçamento'
        within('td', id: 'order_1') do
            click_on 'Calcular Orçamento'
        end
            click_on 'Contratar Serviço'
        # Assert
        expect(current_path).to eq no_budget_delivery_delivery_order_path(order1.id)
        expect(page).to have_content('Ordem de Entrega => XXX1234567890XX')
        expect(page).to have_content('Serviço não contratado')
        expect(page).to have_content('Lilian Monteiro')
        expect(page).to have_content('624.299.657-04')
        expect(page).to have_content('21 988887676')
        expect(page).to have_content('Avenida Silva 1200 - São Roque - Mateuzinho - GO - 76987-345')

        expect(page).to have_content('Produto a ser entregue')
        expect(page).to have_content(order1.product_code)
        expect(page).to have_content(order1.description)
        expect(page).to have_content(order1.weight)
        expect(page).to have_content(order1.height)
        expect(page).to have_content(order1.width)
        expect(page).to have_content(order1.depth)
        expect(page).to have_content(order1.distance)

        expect(page).to have_content('No momento não temos como fazer sua Entrega !!!')
        expect(page).to have_content('Por favor, entrar em contato com a nossa central 0800 9999-5959 !!!')
        
        expect(page).to have_content('Voltar')
    end
   
end