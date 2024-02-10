class Ticket < ApplicationRecord
  belongs_to :room
  belongs_to :event
  belongs_to :user
end
