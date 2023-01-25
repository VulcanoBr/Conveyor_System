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
  
  it 'Placa Identificação deve ter tamanho maximo 8' do

    # Arrange  
    vehicle = Vehicle.new(nameplate: 'KYZ-9268777')
    # Act 
    result = vehicle.errors.include?(:nameplate)
    # Assert
    expect(result).to be false

  end

  it 'Placa Identificação deve ter tamanho minimo 7' do

    # Arrange  
    vehicle = Vehicle.new(nameplate: 'KYZ-92')
    # Act 
    result = vehicle.errors.include?(:nameplate)
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

  it 'Ano fabricação deve ser numerico' do

    # Arrange  não precisa supplier e warehouse
    vehicle = Vehicle.new(year_manufacture: 'XXC')
    # Act 
    result = vehicle.errors.include?(:year_manufacture)
    # Assert
    expect(result).to be false

  end

  it 'Ano fabricação deve ter tamanho 4' do

    # Arrange  não precisa supplier e warehouse
    vehicle = Vehicle.new(year_manufacture: 55555)
    # Act 
    result = vehicle.errors.include?(:year_manufacture)
    # Assert
    expect(result).to be false

  end

  it 'Ano fabricação deve ser menor ou igual ao ano da data de hoje' do

    # Arrange  não precisa supplier e warehouse
    vehicle = Vehicle.new(year_manufacture: Date.today.strftime("%Y").to_i)
    # Act 
    result = vehicle.errors.include?(:year_manufacture)
    # Assert
    expect(result).to be false

  end

  it 'Ano fabricação deve ser maior que  ano de 50 anos atras' do

    # Arrange  não precisa supplier e warehouse
    vehicle = Vehicle.new(year_manufacture: 50.years.ago.year)
    # Act 
    result = vehicle.errors.include?(:year_manufacture)
    # Assert
    expect(result).to be false

  end

  it 'Carga maxima deve ter tamanho maximo 7' do

    # Arrange  não precisa supplier e warehouse
    vehicle = Vehicle.new(maximum_load: 12345678)
    # Act 
    result = vehicle.errors.include?(:maximum_load)
    # Assert
    expect(result).to be false

  end

  it 'Carga maxima deve ser obrigatorio' do

    # Arrange  não precisa supplier e warehouse
    vehicle = Vehicle.new(maximum_load: '')
    # Act 
    result = vehicle.errors.include?(:maximum_load)
    # Assert
    expect(result).to be false

  end

  it 'Carga maxima deve ser numerico' do

    # Arrange  não precisa supplier e warehouse
    vehicle = Vehicle.new(maximum_load: 'xxxxxbmmm')
    # Act 
    result = vehicle.errors.include?(:maximum_load)
    # Assert
    expect(result).to be false

  end

end
