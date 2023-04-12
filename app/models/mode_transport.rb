class ModeTransport < ApplicationRecord

    has_many :prices

    has_many :deadlines

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

    # In the ModeTransport model
    scope :with_prices_and_deadlines_for_order, ->(distance, weight) {
        joins(:prices, :deadlines)
        .where("mode_transports.minimum_distance <= ? AND mode_transports.maximum_distance >= ? 
                AND mode_transports.minimum_weight <= ? AND mode_transports.maximum_weight >= ? 
                AND prices.start_weight <= ? AND prices.final_weight >= ? 
                AND deadlines.start_distance <= ? AND deadlines.final_distance >= ?",
                distance, distance, weight, weight, weight, weight, distance, distance)
        .select("mode_transports.id, mode_transports.delivery_fee, mode_transports.name, 
                prices.km_price, deadlines.deadline_hours")
    }

end
