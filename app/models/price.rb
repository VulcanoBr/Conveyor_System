class Price < ApplicationRecord

  belongs_to :mode_transport

  validates :start_weight, :final_weight, :km_price, presence: true

  validates :start_weight, :final_weight, :km_price, length: { maximum: 6 }

  validates :start_weight, :final_weight, :km_price, numericality: true
            
  validates :start_weight, comparison: { less_than: :final_weight} 
    
  validates :final_weight, comparison: { greater_than: :start_weight} 
end
