class Deadline < ApplicationRecord

  belongs_to :mode_transport

  validates :start_distance, :final_distance, :deadline_hours, presence: true

  validates :start_distance, :final_distance, :deadline_hours, length: { maximum: 6 }

  validates :start_distance, :final_distance, :deadline_hours, numericality: true
            
  validates :start_distance, comparison: { less_than: :final_distance} 
    
  validates :final_distance, comparison: { greater_than: :start_distance} 
                                                            
end
