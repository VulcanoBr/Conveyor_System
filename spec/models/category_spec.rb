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

end
