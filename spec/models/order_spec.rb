require 'rails_helper'

RSpec.describe Order, type: :model do
 
  it 'Codigo Produto deve ser obrigatorio' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(product_code: '')
    # Act 
    result = order.errors.include?(:product_code)
    # Assert
    expect(result).to be false

  end

  it 'Descrição deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(description: '')
    # Act 
    result = order.errors.include?(:description)
    # Assert
    expect(result).to be false

  end

  it 'Peso deve ser obrigatorio' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(height: '')
    # Act 
    result = order.errors.include?(:height)
    # Assert
    expect(result).to be false

  end

  it 'Altura deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(height: '')
    # Act 
    result = order.errors.include?(:height)
    # Assert
    expect(result).to be false

  end

  it 'Largura deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(width: '')
    # Act 
    result = order.errors.include?(:width)
    # Assert
    expect(result).to be false

  end

  it 'Profundidade deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(depth: '')
    # Act 
    result = order.errors.include?(:depth)
    # Assert
    expect(result).to be false

  end

  it 'Nome Remetente deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(sender_name: '')
    # Act 
    result = order.errors.include?(:sender_name)
    # Assert
    expect(result).to be false

  end

  it 'CPF/CNPJ Remetente deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(sender_identification: '')
    # Act 
    result = order.errors.include?(:sender_identification)
    # Assert
    expect(result).to be false

  end

  it 'Email Remetente deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(sender_email: '')
    # Act 
    result = order.errors.include?(:sender_email)
    # Assert
    expect(result).to be false

  end

  it 'Telefone Remetente deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(sender_phone: '')
    # Act 
    result = order.errors.include?(:sender_phone)
    # Assert
    expect(result).to be false

  end

  it 'Endereço Remetente deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(sender_address: '')
    # Act 
    result = order.errors.include?(:sender_address)
    # Assert
    expect(result).to be false

  end

  it 'Numero Remetente deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(sender_number: '')
    # Act 
    result = order.errors.include?(:sender_number)
    # Assert
    expect(result).to be false

  end

  it 'Complemento Remetente deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(sender_complement: '')
    # Act 
    result = order.errors.include?(:sender_complement)
    # Assert
    expect(result).to be false

  end

  it 'Bairro Remetente deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(sender_neighborhood: '')
    # Act 
    result = order.errors.include?(:sender_neighborhood)
    # Assert
    expect(result).to be false

  end

  it 'Cidade Remetente deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(sender_city: '')
    # Act 
    result = order.errors.include?(:sender_city)
    # Assert
    expect(result).to be false

  end

  it 'Estado Remetente deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(sender_state: '')
    # Act 
    result = order.errors.include?(:sender_state)
    # Assert
    expect(result).to be false

  end

  it 'Cep Remetente deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(sender_zipcode: '')
    # Act 
    result = order.errors.include?(:sender_zipcode)
    # Assert
    expect(result).to be false

  end

  it 'Nome Destinatarioe ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(recipient_name: '')
    # Act 
    result = order.errors.include?(:recipient_name)
    # Assert
    expect(result).to be false

  end

  it 'CPF/CNPJ Destinatario deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(recipient_identification: '')
    # Act 
    result = order.errors.include?(:recipient_identification)
    # Assert
    expect(result).to be false

  end

  it 'Email Destinatario deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(recipient_email: '')
    # Act 
    result = order.errors.include?(:recipient_email)
    # Assert
    expect(result).to be false

  end

  it 'Telefone Destinatario deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(recipient_phone: '')
    # Act 
    result = order.errors.include?(:recipient_phone)
    # Assert
    expect(result).to be false

  end

  it 'Endereço Destinatario deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(recipient_address: '')
    # Act 
    result = order.errors.include?(:recipient_address)
    # Assert
    expect(result).to be false

  end

  it 'Numero Destinatario deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(recipient_number: '')
    # Act 
    result = order.errors.include?(:recipient_number)
    # Assert
    expect(result).to be false

  end

  it 'Complemento Destinatario deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(recipient_complement: '')
    # Act 
    result = order.errors.include?(:recipient_Complement)
    # Assert
    expect(result).to be false

  end

  it 'Bairro Destinatario deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(recipient_neighborhood: '')
    # Act 
    result = order.errors.include?(:recipient_neighborhood)
    # Assert
    expect(result).to be false

  end

  it 'Cidade Destinatario deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(recipient_city: '')
    # Act 
    result = order.errors.include?(:recipient_city)
    # Assert
    expect(result).to be false

  end

  it 'Estado Destinatario deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(recipient_state: '')
    # Act 
    result = order.errors.include?(:recipient_state)
    # Assert
    expect(result).to be false

  end

  it 'Cep Destinatario deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(recipient_zipcode: '')
    # Act 
    result = order.errors.include?(:recipient_zipcode)
    # Assert
    expect(result).to be false

  end

  it 'Distancia deve ser obrigatoria' do

    # Arrange  não precisa supplier e warehouse
    order = Order.new(distance: '')
    # Act 
    result = order.errors.include?(:distance)
    # Assert
    expect(result).to be false

  end

  it 'Codigo Pdido deve ter tamanho de 15 caracteres' do

    # Arrange  
    order = Order.new(code: 'XXX1234567890123XXXXX')
    # Act 
    result = order.errors.include?(:code)
    # Assert
    expect(result).to be false

  end

  it 'Peso deve ser numerico' do

    # Arrange  
    order = Order.new(height: '1234567')
    # Act 
    result = order.errors.include?(:height)
    # Assert
    expect(result).to be false

  end

  it 'Altura deve ser numerico' do

    # Arrange  
    order = Order.new(height: '1234567')
    # Act 
    result = order.errors.include?(:height)
    # Assert
    expect(result).to be false

  end

  it 'Largura deve ser numerico' do

    # Arrange  
    order = Order.new(width: '1234567')
    # Act 
    result = order.errors.include?(:width)
    # Assert
    expect(result).to be false

  end

  it 'Profundidade deve ser numerico' do

    # Arrange  
    order = Order.new(depth: '1234567')
    # Act 
    result = order.errors.include?(:depth)
    # Assert
    expect(result).to be false

  end

  it 'Distancia deve ser numerico' do

    # Arrange  
    order = Order.new(distance: '1234567')
    # Act 
    result = order.errors.include?(:distance)
    # Assert
    expect(result).to be false

  end

  it 'CPF/CNPJ Remetente deve ser numerico' do

    # Arrange  
    order = Order.new(sender_identification: '1234567')
    # Act 
    result = order.errors.include?(:sender_identification)
    # Assert
    expect(result).to be false

  end

  it 'CPF/CNPJ Destinatario deve ser numerico' do

    # Arrange  
    order = Order.new(recipient_identification: '1234567')
    # Act 
    result = order.errors.include?(:recipient_identification)
    # Assert
    expect(result).to be false

  end

   it 'CPF Remetente deve ter tamanho 11' do

    # Arrange  
    order = Order.new(sender_identification: 123456789012345)
    # Act 
    result = order.errors.include?(:sender_identification)
    # Assert
    expect(result).to be false
    expect(order.valid?).to be false
  end

  it 'CPF Destinatario deve ter tamanho  11' do

    # Arrange  
    order = Order.new(recipient_identification: 123456789012345)
    # Act 
    result = order.errors.include?(:recipient_identification)
    # Assert
    expect(result).to be false
    expect(order.valid?).to be false
  end

  it 'CNPJ Remetente deve ter tamanho 14' do

    # Arrange  
    order = Order.new(sender_identification: 123456789012345)
    # Act 
    result = order.errors.include?(:sender_identification)
    # Assert
    expect(result).to be false
    expect(order.valid?).to be false
  end

  it 'CNPJ Destinatario deve ter tamanho  14' do

    # Arrange  
    order = Order.new(recipient_identification: 123456789012345)
    # Act 
    result = order.errors.include?(:recipient_identification)
    # Assert
    expect(result).to be false
    expect(order.valid?).to be false
  end

  it 'CPF Remetente deve ser valido' do

    # Arrange  
    order = Order.new(sender_identification: 12345678901)
    # Act 
    result = order.errors.include?(:sender_identification)
    # Assert
    expect(result).to be false
    expect(order.valid?).to be false
  end

  it 'CPF Destinatario deve ser valido' do

    # Arrange  
    order = Order.new(recipient_identification: 12345678901234)
    # Act 
    result = order.errors.include?(:recipient_identification)
    # Assert
    expect(result).to be false
    expect(order.valid?).to be false
  end

  it 'CNPJ Remetente deve ser valido' do

    # Arrange  
    order = Order.new(sender_identification: '12.345.678/9012-34')
    # Act 
    result = order.errors.include?(:sender_identification)
    # Assert
    expect(result).to be false
    expect(order.valid?).to be false
  end

  it 'CNPJ Destinatario deve ser valido' do

    # Arrange  
    order = Order.new(recipient_identification: '12.345.678/9012-34')
    # Act 
    result = order.errors.include?(:recipient_identification)
    # Assert
    expect(result).to be false
    expect(order.valid?).to be false
  end

end
