class Order < ApplicationRecord

   # has_one :order_address, dependent: :destroy
   # accepts_nested_attributes_for :order_address, reject_if: :all_blank, allow_destroy: true

   enum status: {pending: 0}

    validates :product_code, :description, :weight, :height, :width, :depth, :distance, presence: true
    
    validates :weight, :height, :width, :depth, :distance, numericality: { only_integer: true }

    validates  :sender_name, :sender_identification, :sender_email,
               :sender_phone, :sender_address, :sender_city, :sender_state, :sender_zipcode,
               :recipient_name, :recipient_identification, :recipient_email, :recipient_phone,
               :recipient_address, :recipient_city, :recipient_state, :recipient_zipcode, presence: true

    validates  :sender_identification, :recipient_identification, numericality: { only_integer: true }

    validates :sender_identification, :recipient_identification,  length: { maximum: 11 }

    validates :code,  length: { is: 15 }

    before_validation :generate_code_order, on: :create

    def full_sender_address
        "#{sender_address} - #{sender_city} - #{sender_state} - #{sender_zipcode}"
    end

    def full_recipient_address
        "#{recipient_address} - #{recipient_city} - #{recipient_state} - #{recipient_zipcode}"
    end


    private  

    def generate_code_order
        self.code = SecureRandom.alphanumeric(15).upcase
    end
    
    
end
