require 'rails_helper'

RSpec.describe DeliveryOrder, type: :model do
  
  it 'Data de Entrega deve ser obrigatorio' do

    # Arrange  não precisa supplier e warehouse
    delivery_order = DeliveryOrder.new(delivery_date: '')
    # Act 
    result = delivery_order.errors.include?(:delivery_date)
    # Assert
    expect(result).to be false

  end

  it 'Status de Encerramento deve ser obrigatorio' do

    # Arrange  não precisa supplier e warehouse
    delivery_order = DeliveryOrder.new(closure_status: '')
    # Act 
    result = delivery_order.errors.include?(:closure_status)
    # Assert
    expect(result).to be false

  end

  it 'Data de Entrega tem que ser maior que data de criação da ordem de entrega' do

    # Arrange  
    delivery_order = DeliveryOrder.new(delivery_date: Date.today - 4, created_at: Date.today )
    # Act 
    result = delivery_order.errors.include?(:delivery_date)
    # Assert
    expect(result).to be false

  end

  it 'Motivo do atraso  de ser obrigatorio, quando Status de encerramento igual "closed late' do

    # Arrange  
    delivery_order = DeliveryOrder.new(delivery_reason: '', closure_status: :closed_late )
    # Act 
    result = delivery_order.errors.include?(:delivery_reason)
    # Assert
    expect(result).to be false

  end

end
