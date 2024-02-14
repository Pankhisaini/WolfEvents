class Ticket < ApplicationRecord

  validates :number_of_tickets, presence: true
  validates :confirmation_number, presence: true

  belongs_to :room
  belongs_to :event
  belongs_to :user
end
