require 'rails_helper'

RSpec.describe User, type: :model do
  it 'name is mandatory' do

    # Arrange
    user = User.new(name:'')

    # Act
    result = user.valid?

    # Assert
    expect(result).to eq false
  end

end
