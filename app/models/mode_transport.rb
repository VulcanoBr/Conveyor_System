class ModeTransport < ApplicationRecord

    enum status: {active: 0, disabled: 1}

    validates :name, :minimum_distance, :maximum_distance, :minimum_weight,
              :maximum_weight, :delivery_fee, presence: true

    validates :name, uniqueness: {case_sensitive: false}

    validates :minimum_distance, :maximum_distance, :minimum_weight, 
              :maximum_weight,  length: { maximum: 6 }

    validates :minimum_distance, :maximum_distance, :minimum_weight, 
              :maximum_weight,  numericality: { only_integer: true }
            
    validates :minimum_distance, comparison: { less_than_or_equal_to: :maximum_distance} 
    validates :minimum_weight, comparison: { less_than_or_equal_to: :maximum_weight} 
    
    validates :maximum_distance, comparison: { greater_than_or_equal_to: :minimum_distance} 
    validates :maximum_weight, comparison: { greater_than_or_equal_to: :minimum_weight} 
                                                            
    validates :delivery_fee, numericality: true

    validates :delivery_fee,  length: { maximum: 10 }
end
