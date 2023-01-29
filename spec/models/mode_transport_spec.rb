require 'rails_helper'

RSpec.describe ModeTransport, type: :model do
  
  it 'Nome deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    mode_transport = ModeTransport.new(name: '')
    # Act 
    result = mode_transport.errors.include?(:name)
    # Assert
    expect(result).to be false

  end

  it 'Nome deve ser unico' do

    # Arrange  
    ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
          minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: 0)
    mode_transport = ModeTransport.new(name: 'Entrega Expressa')
    # Act 
    result = mode_transport.errors.include?(:name)
    # Assert
    expect(result).to be false

  end

  
  it 'Distancia Minima e obrigatoria' do

    # Arrange  
    mode_transport = ModeTransport.new(minimum_distance: '')
    # Act 
    result = mode_transport.errors.include?(:minimum_distance)
    # Assert
    expect(result).to be false

  end
  
  it 'Distancia Minima deve ter tamanho maximo 6' do

    # Arrange  
    mode_transport = ModeTransport.new(minimum_distance: 1234567)
    # Act 
    result = mode_transport.errors.include?(:minimum_distance)
    # Assert
    expect(result).to be false

  end

  it 'Distancia Minima deve ser numerico' do

    # Arrange  
    mode_transport = ModeTransport.new(minimum_distance: '1234567')
    # Act 
    result = mode_transport.errors.include?(:minimum_distance)
    # Assert
    expect(result).to be false

  end

  it 'Distancia Minima deve ser menor ou igual a distancia maxima' do

    # Arrange  
    mode_transport = ModeTransport.new(minimum_distance: 123456, maximum_distance: 123)
    # Act 
    result = mode_transport.errors.include?(:minimum_distance)
    # Assert
    expect(result).to be false

  end

  
  it 'Distancia Maxima e obrigatoria' do

    # Arrange  
    mode_transport = ModeTransport.new(maximum_distance: '')
    # Act 
    result = mode_transport.errors.include?(:maximum_distance)
    # Assert
    expect(result).to be false

  end
  
  it 'Distancia Maxima deve ter tamanho maximo 6' do

    # Arrange  
    mode_transport = ModeTransport.new(maximum_distance: 1234567)
    # Act 
    result = mode_transport.errors.include?(:maximum_distance)
    # Assert
    expect(result).to be false

  end

  it 'Distancia Maxima deve ser numerico' do

    # Arrange  
    mode_transport = ModeTransport.new(maximum_distance: '1234567')
    # Act 
    result = mode_transport.errors.include?(:maximum_distance)
    # Assert
    expect(result).to be false

  end

  it 'Distancia Maximaa deve  ser maior ou igual a distancia minima' do

    # Arrange  
    mode_transport = ModeTransport.new(minimum_distance: 26, maximum_distance: 123)
    # Act 
    result = mode_transport.errors.include?(:minimum_distance)
    # Assert
    expect(result).to be false

  end

  
  it 'Peso Minimo e obrigatoria' do

    # Arrange  
    mode_transport = ModeTransport.new(minimum_weight: '')
    # Act 
    result = mode_transport.errors.include?(:minimum_weight)
    # Assert
    expect(result).to be false

  end
  
  it 'Peso Minimo deve ter tamanho maximo 6' do

    # Arrange  
    mode_transport = ModeTransport.new(minimum_weight: 1234567)
    # Act 
    result = mode_transport.errors.include?(:minimum_weight)
    # Assert
    expect(result).to be false

  end

  it 'Peso Minimo deve ser numerico' do

    # Arrange  
    mode_transport = ModeTransport.new(minimum_weight: '1234567')
    # Act 
    result = mode_transport.errors.include?(:minimum_weight)
    # Assert
    expect(result).to be false

  end

  it 'Peso Minimo deve ser menor ou igual a peso maximo' do

    # Arrange  
    mode_transport = ModeTransport.new(minimum_weight: 123456, maximum_weight: 123)
    # Act 
    result = mode_transport.errors.include?(:minimum_weight)
    # Assert
    expect(result).to be false

  end

  
  it 'Peso Maximo e obrigatoria' do

    # Arrange  
    mode_transport = ModeTransport.new(maximum_weight: '')
    # Act 
    result = mode_transport.errors.include?(:maximum_weight)
    # Assert
    expect(result).to be false

  end
  
  it 'Peso Maximo deve ter tamanho maximo 6' do

    # Arrange  
    mode_transport = ModeTransport.new(maximum_weight: 1234567)
    # Act 
    result = mode_transport.errors.include?(:maximum_weight)
    # Assert
    expect(result).to be false

  end

  it 'Peso Maximo deve ser numerico' do

    # Arrange  
    mode_transport = ModeTransport.new(maximum_weight: '1234567')
    # Act 
    result = mode_transport.errors.include?(:maximum_weight)
    # Assert
    expect(result).to be false

  end

  it 'Peso Maximo deve ser maior ou igual ao peso minimo' do

    # Arrange  
    mode_transport = ModeTransport.new(minimum_weight: 123456, maximum_weight: 123)
    # Act 
    result = mode_transport.errors.include?(:maximum_weight)
    # Assert
    expect(result).to be false

  end

  
  it 'Taxa de entrega e obrigatoria' do

    # Arrange  
    mode_transport = ModeTransport.new(delivery_fee: '')
    # Act 
    result = mode_transport.errors.include?(:delivery_fee)
    # Assert
    expect(result).to be false

  end
  
  it 'Taxa de entrega deve ter tamanho maximo 10' do

    # Arrange  
    mode_transport = ModeTransport.new(delivery_fee: 123456789012)
    # Act 
    result = mode_transport.errors.include?(:delivery_fee)
    # Assert
    expect(result).to be false

  end

  it 'Taxa de entrega deve ser numerico' do

    # Arrange  
    mode_transport = ModeTransport.new(delivery_fee: '1234567')
    # Act 
    result = mode_transport.errors.include?(:delivery_fee)
    # Assert
    expect(result).to be false

  end

end
