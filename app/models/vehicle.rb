class Vehicle < ApplicationRecord

  belongs_to :category

  enum status: {in_operation: 0}

  validates :nameplate, :brand, :vehicle_model, :year_manufacture, :maximum_load, :category_id, presence:true

  validates :nameplate, uniqueness: {case_sensitive: false}

end
