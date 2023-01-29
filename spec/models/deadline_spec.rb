require 'rails_helper'

RSpec.describe Deadline, type: :model do
  
  it 'Distancia Inicio e obrigatoria' do

    # Arrange  
    deadline = Deadline.new(start_distance: '')
    # Act 
    result = deadline.errors.include?(:start_distance)
    # Assert
    expect(result).to be false

  end
  
  it 'Distancia Inicio deve ter tamanho maximo 6' do

    # Arrange  
    deadline = Deadline.new(start_distance: 1234567)
    # Act 
    result = deadline.errors.include?(:start_distance)
    # Assert
    expect(result).to be false

  end

  it 'Distancia Inicio deve ser numerico' do

    # Arrange  
    deadline = Deadline.new(start_distance: '1234567')
    # Act 
    result = deadline.errors.include?(:start_distance)
    # Assert
    expect(result).to be false

  end

  it 'Distancia Inicio deve ser menor que distancia final' do

    # Arrange  
    deadline = Deadline.new(start_distance: 123456, final_distance: 123)
    # Act 
    result = deadline.errors.include?(:start_distance)
    # Assert
    expect(result).to be false

  end

  it 'Distancia Final e obrigatoria' do

    # Arrange  
    deadline = Deadline.new(final_distance: '')
    # Act 
    result = deadline.errors.include?(:final_distance)
    # Assert
    expect(result).to be false

  end
  
  it 'Distancia Final deve ter tamanho maximo 6' do

    # Arrange  
    deadline = Deadline.new(final_distance: 1234567)
    # Act 
    result = deadline.errors.include?(:final_distance)
    # Assert
    expect(result).to be false

  end

  it 'Distancia Final deve ser numerico' do

    # Arrange  
    deadline = Deadline.new(final_distance: '1234567')
    # Act 
    result = deadline.errors.include?(:final_distance)
    # Assert
    expect(result).to be false

  end

  it 'Distancia Final deve ser naior que distancia inicio' do

    # Arrange  
    deadline = Deadline.new(final_distance: 123, start_distance: 5123)
    # Act 
    result = deadline.errors.include?(:final_distance)
    # Assert
    expect(result).to be false

  end

  it 'Prazo e obrigatoria' do

    # Arrange  
    deadline = Deadline.new(deadline_hours: '')
    # Act 
    result = deadline.errors.include?(:deadline_hours)
    # Assert
    expect(result).to be false

  end
  
  it 'Prazo deve ter tamanho maximo 6' do

    # Arrange  
    deadline = Deadline.new(deadline_hours: 1234567)
    # Act 
    result = deadline.errors.include?(:deadline_hours)
    # Assert
    expect(result).to be false

  end

  it 'Prazo deve ser numerico' do

    # Arrange  
    deadline = Deadline.new(deadline_hours: '1234567')
    # Act 
    result = deadline.errors.include?(:deadline_hours)
    # Assert
    expect(result).to be false

  end

end
