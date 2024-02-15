class Ticket < ApplicationRecord

  validates :number_of_tickets, presence: true
  validates :confirmation_number, presence: true, numericality: { greater_than_or_equal_to: 1 }

  belongs_to :room
  belongs_to :event
  belongs_to :user
end
