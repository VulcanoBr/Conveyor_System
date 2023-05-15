require 'rails_helper'

describe 'Veiculo muda de status' do
    it 'para em entrega(in_delivery)' do
        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
            year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        #vehicle1.in_delivery!
        expect { vehicle1.in_delivery! }.to change { vehicle1.status }.from('in_operation').to('in_delivery')
        #expect(vehicle1.status).to eq('in_delivery')
    end
end