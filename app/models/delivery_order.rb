class DeliveryOrder < ApplicationRecord
  belongs_to :order
  belongs_to :mode_transport
  belongs_to :vehicle

  enum status: { in_delivery: 1, closed: 2 }

  enum closure_status: { closed_on_time: 0, closed_late: 1 }

  validates :delivery_date, :closure_status, presence: true, on: :update

  validates :delivery_reason, presence: true, if: -> {closure_status == "closed_late"} 

  validates :delivery_date, comparison: { greater_than_or_equal_to: :created_at}, on: :update

end
