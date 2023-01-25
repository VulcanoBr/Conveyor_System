require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  
  it 'Placa de identificaçãoa deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    vehicle = Vehicle.new(brand: '')
    # Act 
    result = vehicle.errors.include?(:brand)
    # Assert
    expect(result).to be false

  end

  it 'Marca deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    vehicle = Vehicle.new(brand: '')
    # Act 
    result = vehicle.errors.include?(:brand)
    # Assert
    expect(result).to be false

  end

  it 'Modelo deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    vehicle = Vehicle.new(vehicle_model: '')
    # Act 
    result = vehicle.errors.include?(:vehicle_model)
    # Assert
    expect(result).to be false

  end

  it 'Ano fabricação deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    vehicle = Vehicle.new(year_manufacture: '')
    # Act 
    result = vehicle.errors.include?(:year_manufacture)
    # Assert
    expect(result).to be false

  end

  it 'Placa Identificação deve ser unica' do

    # Arrange  
    category = Category.create!(name: 'Carro')
    Vehicle.create!(nameplate: 'KYZ-9268', brand: 'Ford', vehicle_model: 'Mustang',
                    year_manufacture: 2020, maximum_load: 250000, category_id: category.id, status: :in_operation)
    vehicle = Vehicle.new(nameplate: 'KYZ-9268')
    # Act 
    result = vehicle.errors.include?(:nameplate)
    # Assert
    expect(result).to be false

  end

 
end
