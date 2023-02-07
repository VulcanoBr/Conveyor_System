class Vehicle < ApplicationRecord

  belongs_to :category

  enum status: {in_operation: 0, under_maintenance: 1, in_delivery: 2, disabled: 3}

  validates :nameplate, :brand, :vehicle_model, :year_manufacture, :maximum_load, :category_id, presence:true

  validates :nameplate, uniqueness: {case_sensitive: false}

  validates :nameplate, length: { minimum: 7, maximum: 8 }

  validates :year_manufacture, length: { is: 4 }

  validates :year_manufacture, numericality: { only_integer: true }

  validates :year_manufacture, comparison: { less_than_or_equal_to: Date.today.strftime("%Y").to_i, 
                                              greater_than:  50.years.ago.year}

  validates :maximum_load, length: { maximum: 7}

  validates :maximum_load, numericality: { only_integer: true }

  
  def full_description
    "#{vehicle_model} - #{brand} / #{year_manufacture}      placa: #{nameplate}"
end

end
