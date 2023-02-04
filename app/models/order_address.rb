class OrderAddress < ApplicationRecord

    belongs_to :order

    validates  :sender_name, :sender_identification, :sender_email,
               :sender_phone, :sender_address, :sender_city, :sender_state, :sender_zipcode,
               :recipient_name, :recipient_identification, :recipient_email, :recipient_phone,
               :recipient_address, :recipient_city, :recipient_state, :recipient_zipcode, presence: true

    validates  :sender_identification, :recipient_identification, numericality: { only_integer: true }
    
end
