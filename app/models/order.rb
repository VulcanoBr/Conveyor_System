class Order < ApplicationRecord

    before_validation :generate_code_order, on: :create

    enum status: {pending: 0, in_delivery: 1, closed: 2}

    validates :product_code, :description, :weight, :height, :width, :depth, :distance, presence: true
    
    validates :weight, :height, :width, :depth, :distance, numericality: { only_integer: true }

    validates  :sender_name, :sender_identification, :sender_email,
               :sender_phone, :sender_address, :sender_number, :sender_neighborhood, 
               :sender_city, :sender_state, :sender_zipcode,
               :recipient_name, :recipient_identification, :recipient_email, :recipient_phone,
               :recipient_address, :recipient_number, :recipient_neighborhood, 
               :recipient_city, :recipient_state, :recipient_zipcode, presence: true

    validates :code,  length: { is: 15 }

    validate :cpf_cnpj_sender_length, if: -> { sender_identification.present? }
    validate :cpf_cnpj_recipient_length, if: -> { recipient_identification.present? }
    validate :cpf_sender_valid, if: -> { sender_identification.to_s.length == 14 }
    validate :cpf_recipient_valid, if: -> { recipient_identification.to_s.length == 14 }
    validate :cnpj_sender_valid, if: -> { sender_identification.to_s.length == 18 }
    validate :cnpj_recipient_valid, if: -> { recipient_identification.to_s.length == 18 }


    def full_sender_address
        "#{sender_address} #{sender_number} #{sender_complement} - #{sender_neighborhood} - 
         #{sender_city} - #{sender_state} - #{sender_zipcode}"
    end

    def full_recipient_address
        "#{recipient_address} #{recipient_number} #{recipient_complement} - 
         #{recipient_neighborhood} - #{recipient_city} - #{recipient_state} - #{recipient_zipcode}"
    end


    private  

    def generate_code_order
        self.code = SecureRandom.alphanumeric(15).upcase
    end
    
    def cpf_sender_valid
        errors.add(:sender_identification, " inválido") unless CPF.valid?(sender_identification)
    end
    
    def cpf_recipient_valid
        errors.add(:recipient_identification, " inválido") unless CPF.valid?(recipient_identification)
    end
    def cnpj_sender_valid
        errors.add(:sender_identification, " inválido") unless CNPJ.valid?(sender_identification)
    end
    
    def cnpj_recipient_valid
        errors.add(:recipient_identification, " inválido") unless CNPJ.valid?(recipient_identification)
    end
    
    def cpf_cnpj_sender_length
        return if sender_identification.to_s.length == 14 || sender_identification.to_s.length == 18
    
        errors.add(:sender_identification, 'deve ter 11 ou 14 caracteres')
    end    

    def cpf_cnpj_recipient_length
        return if recipient_identification.to_s.length == 14 || recipient_identification.to_s.length == 18
    
        errors.add(:recipient_identification, ' deve ter 11 ou 14 caracteres')
    end
end
