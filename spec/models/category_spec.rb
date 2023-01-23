require 'rails_helper'

RSpec.describe Category, type: :model do
  
  it 'name is mandatory' do

    # Arrange
    category = Category.new(name:'')

    # Act
    result = category.valid?

    # Assert
    expect(result).to eq false
  end

  it 'name not is unique' do

    # Arrange
    category1 = Category.create!(name:'Vulcano')
    category2 = Category.new(name:'Vulcano')

    category2.save

    # Assert
    expect(category2.name).to eq(category1.name)
  end

  it 'name is unique' do

    # Arrange
    category1 = Category.create!(name:'Vulcano')
    category2 = Category.new(name:'Sanurai')

    category2.save!

    # Assert
    expect(category2.name).not_to eq(category1.name)
  end

end
