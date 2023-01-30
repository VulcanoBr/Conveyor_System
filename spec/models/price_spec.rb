require 'rails_helper'

RSpec.describe Price, type: :model do
  
  it 'Peso Inicial e obrigatoria' do

    # Arrange  
    price = Price.new(start_weight: '')
    # Act 
    result = price.errors.include?(:start_weight)
    # Assert
    expect(result).to be false

  end
  
  it 'Peso Inicial deve ter tamanho maximo 6' do

    # Arrange  
    price = Price.new(start_weight: 1234567)
    # Act 
    result = price.errors.include?(:start_weight)
    # Assert
    expect(result).to be false

  end

  it 'Peso Inicial deve ser numerico' do

    # Arrange  
    price = Price.new(start_weight: '1234567')
    # Act 
    result = price.errors.include?(:start_weight)
    # Assert
    expect(result).to be false

  end

  it 'Peso Inicial deve ser menor que Peso final' do

    # Arrange  
    price = Price.new(start_weight: 123456, final_weight: 123)
    # Act 
    result = price.errors.include?(:start_weight)
    # Assert
    expect(result).to be false

  end

  it 'Peso Final e obrigatoria' do

    # Arrange  
    price = Price.new(final_weight: '')
    # Act 
    result = price.errors.include?(:final_weight)
    # Assert
    expect(result).to be false

  end
  
  it 'Peso Final deve ter tamanho maximo 6' do

    # Arrange  
    price = Price.new(final_weight: 1234567)
    # Act 
    result = price.errors.include?(:final_weight)
    # Assert
    expect(result).to be false

  end

  it 'Peso Final deve ser numerico' do

    # Arrange  
    price = Price.new(final_weight: '1234567')
    # Act 
    result = price.errors.include?(:final_weight)
    # Assert
    expect(result).to be false

  end

  it 'Peso Final deve ser naior que Peso Inicial' do

    # Arrange  
    price = Price.new(final_weight: 123, start_weight: 5123)
    # Act 
    result = price.errors.include?(:final_weight)
    # Assert
    expect(result).to be false

  end

  it 'Preco e obrigatoria' do

    # Arrange  
    price = Price.new(km_price: '')
    # Act 
    result = price.errors.include?(:km_price)
    # Assert
    expect(result).to be false

  end
  
  it 'Preco deve ter tamanho maximo 6' do

    # Arrange  
    price = Price.new(km_price: 1234567)
    # Act 
    result = price.errors.include?(:km_price)
    # Assert
    expect(result).to be false

  end

  it 'Preco deve ser numerico' do

    # Arrange  
    price = Price.new(km_price: '1234567')
    # Act 
    result = price.errors.include?(:km_price)
    # Assert
    expect(result).to be false

  end

end
