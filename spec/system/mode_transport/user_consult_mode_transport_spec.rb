require 'rails_helper'

describe 'Usuario consulta Modalidades' do

        it 've todas modalidades' do

            # Arrange
            mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
                minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: 0)
            mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                    minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :disabled)
            mod3 = ModeTransport.create!(name: 'Carga Pesada', minimum_distance: 0, maximum_distance: 21100, 
                            minimum_weight: 0, maximum_weight: 10000, delivery_fee: 1750.0, status: :active)

            # Act
            visit root_path
            click_on 'Cadastro'
            click_on 'Modalidades'
            click_on 'Consulta Modalidades'

            # Assert
            expect(current_path).to eq  consult_mode_transports_path
            expect(page).not_to have_content('Não ha Modalidades cadastradas !!!')
            expect(page).to have_content('Modalidades Ativas')
            expect(page).to have_content('Entrega Rapida')
            expect(page).to have_content('0')
            expect(page).to have_content('500')
            expect(page).to have_content('Carga Pesada')
            expect(page).to have_content('0')
            expect(page).to have_content('21100')
            expect(page).to have_content('Modalidades Inativas')
            expect(page).to have_content('Entrega Expressa')
            expect(page).to have_content('0')
            expect(page).to have_content('100')

            expect(page).to have_content('Voltar')
           
        end

        it 've detalhes da modalidade' do

            # Arrange
            mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
                minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: 0)
            mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                    minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :disabled)
            mod3 = ModeTransport.create!(name: 'Carga Pesada', minimum_distance: 0, maximum_distance: 21100, 
                            minimum_weight: 0, maximum_weight: 10000, delivery_fee: 1750.0, status: :active)

            price1 = Price.create!(start_weight:0, final_weight: 100, km_price: 0.24, mode_transport_id: mod2.id)
            price2 = Price.create!(start_weight:101, final_weight: 300, km_price: 0.48,mode_transport_id: mod2.id)
            price3 = Price.create!(start_weight:301, final_weight: 600, km_price: 0.72, mode_transport_id: mod2.id)
            
            deadline1 = Deadline.create!(start_distance:0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod2.id)
            deadline2 = Deadline.create!(start_distance:101, final_distance: 300, deadline_hours: 48,mode_transport_id: mod2.id)
            deadline3 = Deadline.create!(start_distance:301, final_distance: 600, deadline_hours: 72, mode_transport_id: mod2.id)
        

            # Act
            visit root_path
            click_on 'Cadastro'
            click_on 'Modalidades'
            click_on 'Consulta Modalidades'
            within('td#details') do
                click_on 'Ver Detalhes'
            end

            # Assert
            expect(current_path).to eq  details_mode_transport_path(mod2.id)
            
            expect(page).to have_content("Modalidade #{mod2.name}")
            expect(page).to have_content('0')
            expect(page).to have_content('100')
            expect(page).to have_content('0')
            expect(page).to have_content('10')
            expect(page).to have_content('R$ 50,00')
            
            expect(page).to have_content('Tabela de Preço')
            expect(page).to have_content('0')
            expect(page).to have_content('100')
            expect(page).to have_content('R$ 0,24')
            expect(page).to have_content('101')
            expect(page).to have_content('300')
            expect(page).to have_content('R$ 0,48')

            expect(page).to have_content('Tabela de Prazo')
            expect(page).to have_content('0')
            expect(page).to have_content('100')
            expect(page).to have_content('24')
            expect(page).to have_content('101')
            expect(page).to have_content('300')
            expect(page).to have_content('48')

            expect(page).to have_content('Voltar')
           
        end


end